import pandas as pd
import os
import re
import io
import random
import logging
from datetime import datetime
import warnings

# --- Configuration ---
METADATA_FILE = 'datasets_info.md'
OUTPUT_FILE = 'data_summary.md'
DATA_SUBDIRECTORY = 'Data'
NUM_RANDOM_COLS = 1000  # Updated limit
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR_PATH = os.path.join(CURRENT_DIR, DATA_SUBDIRECTORY)

# --- Setup Logging ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
# Suppress specific warnings if needed (e.g., from regex or pandas)
warnings.filterwarnings("ignore", category=UserWarning, module='re')

# --- Helper Function to Capture df.info() ---
def get_df_info_string(df):
    """Captures the output of df.info() into a string."""
    buffer = io.StringIO()
    # Show memory usage, important for potentially large transposed data
    df.info(buf=buffer, verbose=True, show_counts=True, memory_usage='deep')
    return buffer.getvalue()

# --- Function to Parse Metadata ---
def parse_metadata(metadata_filepath):
    """ Parses the metadata markdown file. (No changes needed here) """
    metadata_map = {}
    if not os.path.exists(metadata_filepath):
        logging.error(f"Metadata file not found: {metadata_filepath}")
        return None
    try:
        with open(metadata_filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        pattern = re.compile(
            r"###\s+\d+\.\s+``(.*?.csv)``\s*\n(.*?)(?=\n###\s+\d+\.\s+``|\Z)",
            re.DOTALL | re.IGNORECASE
        )
        matches = pattern.findall(content)
        if not matches:
            logging.warning(f"No metadata sections found in {metadata_filepath} using format '### X. ``filename.csv``'.")
        for filename, meta_text in matches:
            clean_filename = filename.lower().strip()
            metadata_map[clean_filename] = meta_text.strip()
            logging.info(f"Parsed metadata for: {clean_filename}")
        if not metadata_map:
             logging.warning(f"Could not extract any metadata from {metadata_filepath}. Check formatting.")
    except Exception as e:
        logging.error(f"Error reading/parsing metadata file {metadata_filepath}: {e}")
        return None
    return metadata_map

# --- Main Processing Function ---
def process_csv_files(script_dir, data_dir, metadata_map):
    """ Processes CSV files, transposing them assuming wide format. """
    markdown_output = []
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    markdown_output.append(f"# Data Summary Report (Transposed Wide Format)")
    markdown_output.append(f"Generated on: {current_time}")
    markdown_output.append("\n---\n")
    markdown_output.append("## Overview")
    markdown_output.append(f"This report summarizes CSV datasets from the subdirectory: `{os.path.basename(data_dir)}`.")
    markdown_output.append(f"**Important:** Based on the likely 'wide' format (rows=series, columns=time), the script **transposes** each dataset after reading.")
    markdown_output.append(f"  * Original rows (series identifiers) become the new columns.")
    markdown_output.append(f"  * Original columns (time points/attributes) become the new index.")
    markdown_output.append(f"Summaries below reflect this **transposed** structure.")
    markdown_output.append(f"Metadata sourced from `{METADATA_FILE}` in `{script_dir}`.")
    markdown_output.append(f"For datasets with >{NUM_RANDOM_COLS} series (original rows), a random sample of {NUM_RANDOM_COLS} series is shown.")
    markdown_output.append("\n---\n")

    if not os.path.isdir(data_dir):
        logging.error(f"Data directory not found: {data_dir}")
        markdown_output.append(f"**Error:** Data directory `{data_dir}` not found.")
        return "\n".join(markdown_output)

    logging.info(f"Looking for CSV files in: {data_dir}")
    try:
        found_csv_files = sorted([f for f in os.listdir(data_dir) if f.lower().endswith('.csv')])
    except Exception as e:
        logging.error(f"Error listing files in {data_dir}: {e}")
        markdown_output.append(f"**Error:** Could not list files in `{data_dir}`: {e}")
        return "\n".join(markdown_output)

    logging.info(f"Found {len(found_csv_files)} CSV files: {found_csv_files}")

    if not found_csv_files:
        markdown_output.append(f"No CSV files found in directory: `{data_dir}`")
        return "\n".join(markdown_output)

    for filename in found_csv_files:
        filepath = os.path.join(data_dir, filename)
        logging.info(f"Processing file: {filepath}")
        markdown_output.append(f"\n## Analysis for: `{filename}` (in `{os.path.basename(data_dir)}` directory)\n")
        markdown_output.append(f"**Note:** Data below is shown after transposing the original file.\n") # Add transposition note per file

        # Add Metadata
        if metadata_map:
            metadata_key = filename.lower()
            if metadata_key in metadata_map:
                markdown_output.append("### Metadata (from `datasets_info.md`)\n")
                metadata_block = "> " + metadata_map[metadata_key].replace("\n", "\n> ")
                markdown_output.append(metadata_block)
                markdown_output.append("\n")
            else:
                 markdown_output.append(f"*\tNo specific metadata found for `{filename}`.*\n")
        else:
            markdown_output.append(f"*\tMetadata file `{METADATA_FILE}` not found or parsed.*\n")

        try:
            # Read CSV
            try:
                df_orig = pd.read_csv(filepath)
            except UnicodeDecodeError:
                logging.warning(f"UTF-8 decoding failed for {filename}. Trying 'latin1'.")
                df_orig = pd.read_csv(filepath, encoding='latin1')
            # Store original shape for reference
            original_shape = df_orig.shape

            if df_orig.empty or original_shape[1] == 0:
                 logging.warning(f"File {filename} is empty or has no columns. Skipping transposition and detailed analysis.")
                 markdown_output.append("### Basic Information\n")
                 markdown_output.append(f"* **Original Shape:** {original_shape} (rows, columns)")
                 markdown_output.append("* File appears empty or lacks columns. Cannot transpose or analyze further.*\n")
                 markdown_output.append("\n---\n")
                 continue

            # --- Transposition Logic ---
            transposed = False
            identifier_col_name = None
            df = df_orig # Start with original df
            try:
                # Assume first column is the identifier
                identifier_col_name = df_orig.columns[0]
                logging.info(f"Assuming '{identifier_col_name}' as identifier column for {filename}.")
                df = df_orig.set_index(identifier_col_name)

                # Transpose
                df = df.T
                transposed = True
                logging.info(f"Successfully transposed {filename}.")

                # Attempt numeric conversion (important after T)
                logging.info(f"Attempting numeric conversion for columns (original rows) of {filename}.")
                df = df.apply(pd.to_numeric, errors='ignore') # 'ignore' keeps non-numeric as object

            except Exception as e_transpose:
                logging.error(f"Failed to set index or transpose {filename}: {e_transpose}. Analyzing original structure.")
                markdown_output.append(f"**Warning:** Failed to transpose the data (Error: {e_transpose}). Displaying analysis of the *original* structure.\n")
                df = df_orig # Revert to original if transpose failed
                transposed = False
            # --- End Transposition Logic ---


            # --- Analysis (on potentially transposed df) ---
            markdown_output.append("### Basic Information\n")
            markdown_output.append(f"* **Original Shape:** {original_shape} (rows, columns)")
            if transposed:
                 markdown_output.append(f"* Identifier Column Assumed: `{identifier_col_name}` (used as new columns)")
                 markdown_output.append(f"* **Shape after Transpose:** {df.shape} (time points/attributes, series)")
                 markdown_output.append(f"* **Index:** Represents original columns (likely time points)")
                 markdown_output.append(f"* **Columns:** Represent original rows (series identifiers)")
            else:
                 markdown_output.append(f"* **Shape (Original):** {df.shape} (rows, columns)")

            markdown_output.append(f"* **Total Cells:** {df.size}")
            dtype_counts = df.dtypes.value_counts().to_dict()
            markdown_output.append(f"* **Data Type Counts {'(after transpose & conversion)' if transposed else ''}:** {dtype_counts}")

            markdown_output.append("\n### DataFrame Info Summary\n")
            markdown_output.append(f"```\n{get_df_info_string(df)}\n```\n")

            markdown_output.append(f"### Missing Values Summary {'(per Series)' if transposed else '(per Column)'}\n")
            missing_values = df.isnull().sum()
            missing_total = missing_values.sum()
            missing_values = missing_values[missing_values > 0]
            if not missing_values.empty:
                markdown_output.append(f"Total missing values: {missing_total}")
                markdown_output.append(f"{'Series' if transposed else 'Columns'} with missing values:")
                markdown_output.append(f"```\n{missing_values.to_string()}\n```\n")
            else:
                markdown_output.append("* No missing values found.*\n")

            # Unique Values - Less useful after transpose maybe, but keep for now
            markdown_output.append(f"### Unique Values per {'Series' if transposed else 'Column'} (Sample)\n")
            unique_counts = df.nunique()
            markdown_output.append(f"Showing unique counts for first/last 5 {'series' if transposed else 'columns'} (Total: {len(df.columns)}):")
            markdown_output.append("```")
            if len(unique_counts) > 10:
                 markdown_output.append(unique_counts.head(5).to_string())
                 markdown_output.append("\n...\n")
                 markdown_output.append(unique_counts.tail(5).to_string())
            else:
                 markdown_output.append(unique_counts.to_string())
            markdown_output.append("```\n")

            markdown_output.append(f"### Descriptive Statistics {'per Series (over Time)' if transposed else 'per Column'}\n")
            try:
                # Rely on numeric conversion attempt before describe
                desc_stats = df.describe(include='number') # Focus on numeric after potential conversion
                if desc_stats.empty:
                     # Try including object if numeric failed / non-existent
                     desc_stats = df.describe(include=['object', 'category'])
                     if not desc_stats.empty:
                         markdown_output.append("*(Numeric statistics could not be generated. Showing stats for object/category types)*\n")
                     else:
                          markdown_output.append("* No descriptive statistics could be generated.*\n")

                if not desc_stats.empty:
                    markdown_output.append("```markdown")
                    markdown_output.append(desc_stats.to_markdown())
                    markdown_output.append("```\n")

            except Exception as e_desc:
                 logging.error(f"Could not generate descriptive statistics for {filename}: {e_desc}")
                 markdown_output.append("* Could not generate descriptive statistics.*\n")

            # --- Column (Series) Sampling ---
            markdown_output.append(f"### Data Sample ({'Series' if transposed else 'Columns'})\n")
            all_columns = df.columns.tolist() # These are series if transposed
            num_cols = len(all_columns)
            sampled_columns = []
            df_sample_display = pd.DataFrame()

            if num_cols == 0:
                 markdown_output.append(f"* The DataFrame has 0 {'series' if transposed else 'columns'}.*\n")
            elif num_cols > NUM_RANDOM_COLS:
                markdown_output.append(f"* Sampling {NUM_RANDOM_COLS} random {'series' if transposed else 'columns'} (out of {num_cols}).*\n")
                try:
                    sampled_columns = random.sample(all_columns, NUM_RANDOM_COLS)
                    df_sample_display = df[sampled_columns].head() # Show first few time points/rows
                except Exception as e_sample:
                    logging.error(f"Error sampling columns for {filename}: {e_sample}")
                    markdown_output.append(f"* Error during sampling: {e_sample}. Showing head of unsampled data instead.*\n")
                    df_sample_display = df.head() # Fallback

            else:
                markdown_output.append(f"* Showing all {num_cols} {'series' if transposed else 'columns'}.*\n")
                sampled_columns = all_columns
                df_sample_display = df.head()

            if not df_sample_display.empty:
                 markdown_output.append(f"*\tShowing first 5 {'time points / attributes (index)' if transposed else 'rows'} for the selected {'series' if transposed else 'columns'}.*\n")
                 markdown_output.append("```markdown")
                 # Display index (time points if transposed)
                 markdown_output.append(df_sample_display.to_markdown(index=True))
                 markdown_output.append("```\n")
            elif num_cols > 0:
                 markdown_output.append(f"* The DataFrame has {num_cols} {'series' if transposed else 'columns'} but appears to have 0 rows (time points).*\n")


            markdown_output.append("\n---\n") # Separator between files

        # Catch errors during the file reading/processing block
        except FileNotFoundError:
            logging.error(f"File not found error for {filepath}")
            markdown_output.append(f"### Error Reading File\n```\nFile not found at: {filepath}\n```\n")
            markdown_output.append("\n---\n")
        except pd.errors.EmptyDataError:
             logging.warning(f"File {filename} is empty.")
             markdown_output.append(f"### Information\n* File `{filename}` is empty.*\n")
             markdown_output.append("\n---\n")
        except Exception as e:
            logging.error(f"Unexpected error processing {filename}: {e}", exc_info=True) # Log traceback
            markdown_output.append(f"### Error During Processing\n")
            markdown_output.append(f"An unexpected error occurred for `{filename}`. Check logs.\n")
            markdown_output.append(f"```\n{e}\n```\n")
            markdown_output.append("\n---\n")

    return "\n".join(markdown_output)

# --- Main Execution ---
if __name__ == "__main__":
    logging.info("Starting CSV analysis script (with transposition).")
    logging.info(f"Script location: {CURRENT_DIR}")
    logging.info(f"Data directory: {DATA_DIR_PATH}")
    logging.info(f"Metadata file: {os.path.join(CURRENT_DIR, METADATA_FILE)}")
    logging.info(f"Output file: {os.path.join(CURRENT_DIR, OUTPUT_FILE)}")
    logging.info(f"Column/Series sampling limit: {NUM_RANDOM_COLS}")

    metadata_filepath = os.path.join(CURRENT_DIR, METADATA_FILE)
    metadata = parse_metadata(metadata_filepath)
    if metadata is None:
         logging.warning(f"Proceeding without metadata.")
         metadata = {}

    markdown_content = process_csv_files(CURRENT_DIR, DATA_DIR_PATH, metadata)

    output_path = os.path.join(CURRENT_DIR, OUTPUT_FILE)
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(markdown_content)
        logging.info(f"Successfully generated summary report: {output_path}")
    except Exception as e:
        logging.error(f"Failed to write output file {output_path}: {e}")

    logging.info("Script finished.")
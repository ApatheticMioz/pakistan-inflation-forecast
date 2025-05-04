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
OUTPUT_FILE = 'data_summary_original_format.md' # Changed output filename
DATA_SUBDIRECTORY = 'Data'
NUM_RANDOM_COLS = 1000  # Keep the limit for column sampling
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR_PATH = os.path.join(CURRENT_DIR, DATA_SUBDIRECTORY)

# --- Setup Logging ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
warnings.filterwarnings("ignore", category=UserWarning, module='re')
# Ignore DtypeWarning from pandas read_csv if it occurs
warnings.filterwarnings("ignore", category=pd.errors.DtypeWarning)
warnings.filterwarnings("ignore", category=FutureWarning) # Ignore future warnings for now


# --- Helper Function to Capture df.info() ---
def get_df_info_string(df):
    """Captures the output of df.info() into a string."""
    buffer = io.StringIO()
    # Keep deep memory usage calculation as it's valuable info, though can be slow
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
            # No need to log parsing here if it's too verbose
            # logging.info(f"Parsed metadata for: {clean_filename}")
        if not metadata_map:
             logging.warning(f"Could not extract any metadata from {metadata_filepath}. Check formatting.")
    except Exception as e:
        logging.error(f"Error reading/parsing metadata file {metadata_filepath}: {e}")
        return None
    return metadata_map

# --- Main Processing Function ---
def process_csv_files(script_dir, data_dir, metadata_map):
    """ Processes CSV files in their original format for speed. """
    markdown_output = []
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    # Updated Title
    markdown_output.append(f"# Data Summary Report (Original Format)")
    markdown_output.append(f"Generated on: {current_time}")
    markdown_output.append("\n---\n")
    markdown_output.append("## Overview")
    markdown_output.append(f"This report summarizes CSV datasets from the subdirectory: `{os.path.basename(data_dir)}`.")
    markdown_output.append(f"**Note:** Datasets are analyzed in their **original format** (rows=series, columns=time/attributes).")
    markdown_output.append(f"  * No transposition or explicit data type conversion has been performed by this script.")
    markdown_output.append(f"Metadata sourced from `{METADATA_FILE}` in `{script_dir}`.")
    markdown_output.append(f"For datasets with >{NUM_RANDOM_COLS} columns (time/attributes), a random sample of {NUM_RANDOM_COLS} columns is shown.")
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

    logging.info(f"Found {len(found_csv_files)} CSV files.") # Simplified log

    if not found_csv_files:
        markdown_output.append(f"No CSV files found in directory: `{data_dir}`")
        return "\n".join(markdown_output)

    for filename in found_csv_files:
        filepath = os.path.join(data_dir, filename)
        logging.info(f"Processing file: {filename}") # Log only filename for brevity
        markdown_output.append(f"\n## Analysis for: `{filename}` (in `{os.path.basename(data_dir)}` directory)\n")
        # No transposition note needed here

        # Add Metadata
        if metadata_map:
            metadata_key = filename.lower()
            if metadata_key in metadata_map:
                markdown_output.append("### Metadata (from `datasets_info.md`)\n")
                metadata_block = "> " + metadata_map[metadata_key].replace("\n", "\n> ")
                markdown_output.append(metadata_block)
                markdown_output.append("\n")
            # else: # Reduce verbosity by not mentioning missing metadata unless necessary
            #      markdown_output.append(f"*\tNo specific metadata found for `{filename}`.*\n")
        # else: # Reduce verbosity
        #     markdown_output.append(f"*\tMetadata file `{METADATA_FILE}` not found or parsed.*\n")

        try:
            # Read CSV - keep encoding fallback
            try:
                # Use low_memory=False to potentially reduce DtypeWarnings, may use more RAM initially
                df = pd.read_csv(filepath, low_memory=False)
            except UnicodeDecodeError:
                logging.warning(f"UTF-8 decoding failed for {filename}. Trying 'latin1'.")
                df = pd.read_csv(filepath, encoding='latin1', low_memory=False)

            original_shape = df.shape

            if df.empty:
                 logging.warning(f"File {filename} is empty. Skipping analysis.")
                 markdown_output.append("### Basic Information\n")
                 markdown_output.append(f"* **Shape:** {original_shape} (rows, columns)")
                 markdown_output.append("* File appears empty. Skipping detailed analysis.*\n")
                 markdown_output.append("\n---\n")
                 continue

            # --- Analysis (Original Format) ---
            markdown_output.append("### Basic Information\n")
            markdown_output.append(f"* **Shape:** {df.shape} (rows, columns)") # Rows = series, Columns = time/attributes
            markdown_output.append(f"* **Total Cells:** {df.size}")
            dtype_counts = df.dtypes.value_counts().to_dict()
            markdown_output.append(f"* **Data Type Counts (Pandas detected):** {dtype_counts}")

            markdown_output.append("\n### DataFrame Info Summary\n")
            markdown_output.append(f"```\n{get_df_info_string(df)}\n```\n") # Still potentially slow but valuable

            markdown_output.append(f"### Missing Values Summary (per Column)\n") # Summarize per original column
            missing_values = df.isnull().sum()
            missing_total = missing_values.sum()
            missing_values = missing_values[missing_values > 0]
            if not missing_values.empty:
                markdown_output.append(f"Total missing values: {missing_total}")
                markdown_output.append(f"Columns (time/attributes) with missing values:")
                # Limit display if too many columns have missing values
                if len(missing_values) > 50:
                    markdown_output.append("```")
                    markdown_output.append(missing_values.head(25).to_string())
                    markdown_output.append("\n...\n")
                    markdown_output.append(missing_values.tail(25).to_string())
                    markdown_output.append(f"\n(Showing first/last 25 of {len(missing_values)} columns with missing values)")
                    markdown_output.append("```\n")
                else:
                    markdown_output.append(f"```\n{missing_values.to_string()}\n```\n")
            else:
                markdown_output.append("* No missing values found.*\n")

            markdown_output.append(f"### Unique Values per Column (Sample)\n") # Per original column
            unique_counts = df.nunique()
            markdown_output.append(f"Showing unique counts for first/last 5 columns (Total columns: {len(df.columns)}):")
            markdown_output.append("```")
            if len(unique_counts) > 10:
                 markdown_output.append(unique_counts.head(5).to_string())
                 markdown_output.append("\n...\n")
                 markdown_output.append(unique_counts.tail(5).to_string())
            else:
                 markdown_output.append(unique_counts.to_string())
            markdown_output.append("```\n")

            # Use include='all' for broader summary on original format
            markdown_output.append(f"### Descriptive Statistics per Column (Time/Attribute)\n")
            try:
                desc_stats = df.describe(include='all')
                if not desc_stats.empty:
                    markdown_output.append("```markdown")
                    # Limit columns shown in describe if excessively wide
                    if desc_stats.shape[1] > 50:
                         markdown_output.append(f"*(Showing statistics for first/last 25 of {desc_stats.shape[1]} columns)*\n\n")
                         # Display first 25 columns
                         markdown_output.append(desc_stats.iloc[:, :25].to_markdown())
                         markdown_output.append("\n\n...\n\n")
                         # Display last 25 columns
                         markdown_output.append(desc_stats.iloc[:, -25:].to_markdown())
                    else:
                         markdown_output.append(desc_stats.to_markdown())
                    markdown_output.append("```\n")
                else:
                     markdown_output.append("* No descriptive statistics could be generated.*\n")

            except Exception as e_desc:
                 # Broader catch as include='all' can sometimes fail
                 logging.error(f"Could not generate descriptive statistics for {filename}: {e_desc}")
                 markdown_output.append(f"* Could not generate descriptive statistics (Error: {e_desc}).*\n")


            # --- Column (Time/Attribute) Sampling ---
            markdown_output.append(f"### Data Sample (Columns: Time/Attributes)\n")
            all_columns = df.columns.tolist()
            num_cols = len(all_columns)
            sampled_columns = []
            df_sample_display = pd.DataFrame()

            if num_cols == 0:
                 markdown_output.append(f"* The DataFrame has 0 columns.*\n")
            elif num_cols > NUM_RANDOM_COLS:
                markdown_output.append(f"* Sampling {NUM_RANDOM_COLS} random columns (time/attributes) (out of {num_cols}).*\n")
                try:
                    sampled_columns = random.sample(all_columns, NUM_RANDOM_COLS)
                    # Select rows (head) and sampled columns
                    df_sample_display = df.loc[:, sampled_columns].head()
                except Exception as e_sample:
                    logging.error(f"Error sampling columns for {filename}: {e_sample}")
                    markdown_output.append(f"* Error during sampling: {e_sample}. Showing head of unsampled data instead.*\n")
                    df_sample_display = df.head() # Fallback

            else:
                markdown_output.append(f"* Showing all {num_cols} columns.*\n")
                sampled_columns = all_columns
                df_sample_display = df.head()

            if not df_sample_display.empty:
                 # Display rows (series) index
                 markdown_output.append(f"*\tShowing first 5 rows (series) for the selected {len(df_sample_display.columns)} columns (time/attributes).*\n")
                 markdown_output.append("```markdown")
                 markdown_output.append(df_sample_display.to_markdown(index=True))
                 markdown_output.append("```\n")
            elif num_cols > 0:
                 markdown_output.append(f"* The DataFrame has {num_cols} columns but appears to have 0 rows (series).*\n")


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
            logging.error(f"Unexpected error processing {filename}: {e}", exc_info=True)
            markdown_output.append(f"### Error During Processing\n")
            markdown_output.append(f"An unexpected error occurred for `{filename}`. Check logs.\n")
            markdown_output.append(f"```\n{e}\n```\n")
            markdown_output.append("\n---\n")

    return "\n".join(markdown_output)

# --- Main Execution ---
if __name__ == "__main__":
    logging.info("Starting CSV analysis script (Original Format - Optimized for Speed).") # Updated message
    logging.info(f"Script location: {CURRENT_DIR}")
    logging.info(f"Data directory: {DATA_DIR_PATH}")
    logging.info(f"Metadata file: {os.path.join(CURRENT_DIR, METADATA_FILE)}")
    logging.info(f"Output file: {os.path.join(CURRENT_DIR, OUTPUT_FILE)}")
    logging.info(f"Column sampling limit: {NUM_RANDOM_COLS}")

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
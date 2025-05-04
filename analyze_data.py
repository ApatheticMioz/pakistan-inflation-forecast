import pandas as pd
import os
import re
import io
import random
import logging
from datetime import datetime
import warnings
import numpy as np

# --- Configuration ---
METADATA_FILE = 'datasets_info.md'
OUTPUT_FILE = 'data_summary.md'
DATA_SUBDIRECTORY = 'Data'

# Sampling/Display Parameters
NUM_RANDOM_ROWS_TALL = 500    # Number of ROWS (Time Points/Obs) to SAMPLE for display

# Analysis Parameters
CORRELATION_THRESHOLD = 0.8 # Threshold for reporting correlated column pairs
TOP_N_VALUE_COUNTS = 15     # Number of top values to show in value_counts
MAX_COLS_VALUE_COUNTS = 500  # Max number of object columns to show value counts for

# Paths
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR_PATH = os.path.join(CURRENT_DIR, DATA_SUBDIRECTORY)

# --- Setup Logging ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
warnings.filterwarnings("ignore", category=UserWarning, module='re')
warnings.filterwarnings("ignore", category=pd.errors.DtypeWarning)
warnings.filterwarnings("ignore", category=FutureWarning)
warnings.filterwarnings("ignore", category=pd.errors.PerformanceWarning)


# --- Helper Function to Capture df.info() ---
def get_df_info_string(df, detailed_memory=False):
    """Captures the output of df.info() into a string."""
    buffer = io.StringIO()
    mem_usage = 'deep' if detailed_memory else True
    # Limit verbose output if columns exceed a high number to prevent excessive info string length
    verbose_setting = False if df.shape[1] > 500 else True # Disable full column list if > 500 cols
    df.info(buf=buffer, verbose=verbose_setting, show_counts=True, memory_usage=mem_usage)
    return buffer.getvalue()

# --- Function to Parse Metadata ---
# (No changes needed in parse_metadata)
def parse_metadata(metadata_filepath):
    metadata_map = {}
    if not os.path.exists(metadata_filepath): logging.error(f"Metadata file not found: {metadata_filepath}"); return None
    try:
        with open(metadata_filepath, 'r', encoding='utf-8') as f: content = f.read()
        pattern = re.compile(r"###\s+\d+\.\s+``(.*?.csv)``\s*\n(.*?)(?=\n###\s+\d+\.\s+``|\Z)", re.DOTALL | re.IGNORECASE)
        matches = pattern.findall(content)
        if not matches: logging.warning(f"No metadata sections found in {metadata_filepath} using format '### X. ``filename.csv``'.")
        for filename, meta_text in matches: clean_filename = filename.lower().strip(); metadata_map[clean_filename] = meta_text.strip()
        if not metadata_map: logging.warning(f"Could not extract any metadata from {metadata_filepath}. Check formatting.")
    except Exception as e: logging.error(f"Error reading/parsing metadata file {metadata_filepath}: {e}"); return None
    return metadata_map

# --- Helper Function Renamed: Aggregate Summary for Columns ---
def get_column_summary(df):
    """Calculates aggregate statistics for each column (series/attribute) in the DataFrame."""
    if df.empty:
        return pd.DataFrame()

    summary = pd.DataFrame(index=df.columns)
    summary['DataType'] = df.dtypes.astype(str)
    summary['NonNullCount'] = df.count()
    summary['NullCount'] = df.isnull().sum()
    summary['NullPct'] = (df.isnull().sum() / len(df) * 100)
    summary['UniqueCount'] = df.nunique()

    # Calculate numeric stats only where applicable
    numeric_cols = df.select_dtypes(include=np.number).columns
    if not numeric_cols.empty:
        summary.loc[numeric_cols, 'Mean'] = df[numeric_cols].mean()
        summary.loc[numeric_cols, 'StdDev'] = df[numeric_cols].std()
        summary.loc[numeric_cols, 'Min'] = df[numeric_cols].min()
        summary.loc[numeric_cols, '25%'] = df[numeric_cols].quantile(0.25)
        summary.loc[numeric_cols, '50%'] = df[numeric_cols].quantile(0.50)
        summary.loc[numeric_cols, '75%'] = df[numeric_cols].quantile(0.75)
        summary.loc[numeric_cols, 'Max'] = df[numeric_cols].max()
        summary.loc[numeric_cols, 'Skewness'] = df[numeric_cols].skew()
        summary.loc[numeric_cols, 'Kurtosis'] = df[numeric_cols].kurt()

    # Attempt to get first/last non-null values
    try:
        # Convert index to RangeIndex if it's not default for reliable iloc[0]/-1
        temp_df = df.reset_index(drop=True)
        summary['FirstNonNull'] = temp_df.apply(lambda col: col.dropna().iloc[0] if not col.dropna().empty else None)
        summary['LastNonNull'] = temp_df.apply(lambda col: col.dropna().iloc[-1] if not col.dropna().empty else None)
    except Exception:
        logging.warning("Could not reliably determine first/last non-null values for all columns.")
        summary['FirstNonNull'] = 'Error'
        summary['LastNonNull'] = 'Error'

    summary['NullPct'] = summary['NullPct'].map('{:.2f}%'.format)
    numeric_summary_cols = ['Mean', 'StdDev', 'Min', '25%', '50%', '75%', 'Max', 'Skewness', 'Kurtosis']
    for col in numeric_summary_cols:
        if col in summary.columns:
            summary[col] = summary[col].fillna('N/A')

    return summary


# --- Main Processing Function ---
def process_csv_files(script_dir, data_dir, metadata_map):
    """ Processes CSV files assumed TALL, generates comprehensive analysis. """
    markdown_output = []
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    markdown_output.append(f"# Data Summary Report (Assumed Tall Format - Comprehensive)")
    markdown_output.append(f"Generated on: {current_time}")
    markdown_output.append("\n---\n")
    markdown_output.append("## Overview")
    markdown_output.append(f"This report summarizes CSV datasets from the subdirectory: `{os.path.basename(data_dir)}`.")
    markdown_output.append(f"**Format Assumption:** All datasets are assumed to be in **Tall format** (Rows=Time/Obs, Columns=Series/Attrs) and are analyzed as is (no transposition performed).")
    markdown_output.append(f"**Content:** Includes metadata, basic info, memory usage, missing values, unique values, value counts, distribution stats, correlation summary, and a **detailed summary table for every column (series/attribute)**.")
    markdown_output.append(f"Metadata sourced from `{METADATA_FILE}` in `{script_dir}`.")
    markdown_output.append(f"The 'Data Sample' section shows **{NUM_RANDOM_ROWS_TALL} random rows (time points/observations)** across **all columns**.")
    markdown_output.append("\n---\n")

    if not os.path.isdir(data_dir): # Directory check
        logging.error(f"Data directory not found: {data_dir}"); markdown_output.append(f"**Error:** Data directory `{data_dir}` not found."); return "\n".join(markdown_output)

    logging.info(f"Looking for CSV files in: {data_dir}")
    try: # File listing
        found_csv_files = sorted([f for f in os.listdir(data_dir) if f.lower().endswith('.csv')])
    except Exception as e:
        logging.error(f"Error listing files in {data_dir}: {e}"); markdown_output.append(f"**Error:** Could not list files in `{data_dir}`: {e}"); return "\n".join(markdown_output)

    logging.info(f"Found {len(found_csv_files)} CSV files.")
    if not found_csv_files: # Check if files found
        markdown_output.append(f"No CSV files found in directory: `{data_dir}`"); return "\n".join(markdown_output)

    # --- Main Loop ---
    for filename in found_csv_files:
        filepath = os.path.join(data_dir, filename)
        logging.info(f"Processing file: {filename}")
        markdown_output.append(f"\n## Analysis for: `{filename}` (in `{os.path.basename(data_dir)}` directory)\n")

        # Add Metadata
        if metadata_map and filename.lower() in metadata_map:
            markdown_output.append("### Metadata (from `datasets_info.md`)\n"); metadata_key = filename.lower()
            metadata_block = "> " + metadata_map[metadata_key].replace("\n", "\n> "); markdown_output.append(metadata_block); markdown_output.append("\n")

        try:
            # Read CSV
            try: df = pd.read_csv(filepath, low_memory=False)
            except UnicodeDecodeError: logging.warning(f"UTF-8 decoding failed for {filename}. Trying 'latin1'."); df = pd.read_csv(filepath, encoding='latin1', low_memory=False)

            original_shape = df.shape
            num_rows, num_cols = original_shape

            if df.empty: # Handle Empty DataFrame
                 logging.warning(f"File {filename} is empty. Skipping analysis.")
                 markdown_output.append("### Basic Information\n"); markdown_output.append(f"* **Shape:** {original_shape} (rows, columns)\n"); markdown_output.append("* File appears empty. Skipping detailed analysis.*\n"); markdown_output.append("\n---\n"); continue

            # --- Analysis (Assumed Tall Format) ---
            markdown_output.append("### Basic Information\n")
            markdown_output.append(f"* **Shape:** {df.shape} (Rows=Time/Obs, Columns=Series/Attrs)")
            markdown_output.append(f"* **Total Cells:** {df.size}")
            markdown_output.append(f"* **Data Types Summary:** {dict(df.dtypes.value_counts())}")

            # Detailed Memory Usage
            try:
                mem_usage = df.memory_usage(deep=True, index=True); markdown_output.append("\n### Memory Usage (Bytes)\n")
                markdown_output.append(f"* **Total:** {mem_usage.sum():,} Bytes")
                markdown_output.append("* **Per Column (Series/Attrs) + Index:**"); markdown_output.append("```")
                if len(mem_usage) > 50: markdown_output.append(mem_usage.head(25).to_string(float_format='{:,.0f}'.format)); markdown_output.append("\n...\n"); markdown_output.append(mem_usage.tail(25).to_string(float_format='{:,.0f}'.format)); markdown_output.append(f"\n(Showing first/last 25 of {len(mem_usage)} entries)")
                else: markdown_output.append(mem_usage.to_string(float_format='{:,.0f}'.format))
                markdown_output.append("```\n")
            except Exception as e_mem: logging.warning(f"Could not get detailed memory usage: {e_mem}"); markdown_output.append("\n*Could not retrieve detailed memory usage.*\n")

            # DataFrame Info Summary
            markdown_output.append("\n### DataFrame Info Summary\n")
            markdown_output.append(f"```\n{get_df_info_string(df)}\n```\n") # Uses simplified verbose setting now

            # Datetime Column Check (Simple check on first few columns) - More heuristic
            # Note: This is a basic check, might need refinement. Skipping for now to avoid complexity.
            # Consider adding back if date analysis is crucial.

            # Missing Values Summary
            markdown_output.append(f"\n### Missing Values Summary (per Column: Series/Attrs)\n")
            missing_values = df.isnull().sum(); missing_total = missing_values.sum(); missing_values = missing_values[missing_values > 0].sort_values(ascending=False)
            if not missing_values.empty:
                markdown_output.append(f"Total missing values: {missing_total:,} ({missing_total / df.size:.2%})")
                markdown_output.append(f"Columns ({len(missing_values)} of {num_cols}) with missing values (Sorted):"); markdown_output.append("```")
                markdown_output.append(missing_values.to_string()); markdown_output.append("```\n") # Show all
            else: markdown_output.append("* No missing values found.*\n")

            # Unique Values Summary
            markdown_output.append(f"\n### Unique Values per Column (Series/Attrs) (Sample)\n")
            unique_counts = df.nunique(); markdown_output.append(f"Showing unique counts for first/last 10 columns (Total columns: {num_cols}):"); markdown_output.append("```")
            if len(unique_counts) > 20: markdown_output.append(unique_counts.head(10).to_string()); markdown_output.append("\n...\n"); markdown_output.append(unique_counts.tail(10).to_string())
            else: markdown_output.append(unique_counts.to_string())
            markdown_output.append("```\n")

            # Value Counts for Object Columns
            try:
                object_cols = df.select_dtypes(include=['object', 'category']).columns
                if not object_cols.empty:
                    markdown_output.append(f"\n### Value Counts for Categorical/Object Columns (Top {TOP_N_VALUE_COUNTS})\n"); markdown_output.append(f"*Showing top {TOP_N_VALUE_COUNTS} values for up to {MAX_COLS_VALUE_COUNTS} columns.*\n")
                    cols_to_show_counts = object_cols[:MAX_COLS_VALUE_COUNTS]
                    for col in cols_to_show_counts:
                        counts = df[col].value_counts(); markdown_output.append(f"**Column: `{col}`** (Top {min(TOP_N_VALUE_COUNTS, len(counts))} of {counts.count()} unique values)")
                        markdown_output.append("```"); markdown_output.append(counts.head(TOP_N_VALUE_COUNTS).to_string()); markdown_output.append("```")
                    if len(object_cols) > MAX_COLS_VALUE_COUNTS: markdown_output.append(f"\n*... (Value counts for remaining {len(object_cols) - MAX_COLS_VALUE_COUNTS} object columns not shown)*")
                    markdown_output.append("\n")
            except Exception as e_vc: logging.warning(f"Could not generate value counts: {e_vc}"); markdown_output.append("\n*Could not generate value counts.*\n")

            # --- Aggregate Summary Table for ALL Columns ---
            markdown_output.append(f"\n### Column Summary Table (Aggregate Stats per Column)\n") # Renamed from Series Summary
            markdown_output.append(f"*Table showing aggregate statistics calculated for each of the **{num_cols} columns (series/attributes)**.*\n")
            try:
                column_summary_df = get_column_summary(df) # Use renamed helper
                if not column_summary_df.empty:
                    markdown_output.append("```markdown")
                    markdown_output.append(column_summary_df.to_markdown()) # Show entire table
                    markdown_output.append("```\n")
                else:
                     markdown_output.append("*Could not generate column summary table.*\n")
            except Exception as e_agg:
                 logging.error(f"Failed to generate column summary table for {filename}: {e_agg}")
                 markdown_output.append(f"*Could not generate column summary table (Error: {e_agg}).*\n")

            # --- Correlation Summary ---
            try:
                numeric_cols = df.select_dtypes(include=np.number).columns
                if len(numeric_cols) >= 2:
                     markdown_output.append(f"\n### High Correlation Pairs (|Correlation| > {CORRELATION_THRESHOLD})\n"); corr_matrix = df[numeric_cols].corr()
                     high_corr_pairs = corr_matrix.unstack().sort_values(key=abs, ascending=False)
                     high_corr_pairs = high_corr_pairs[high_corr_pairs.index.get_level_values(0) < high_corr_pairs.index.get_level_values(1)]; high_corr_pairs = high_corr_pairs[abs(high_corr_pairs) > CORRELATION_THRESHOLD]
                     if not high_corr_pairs.empty:
                          markdown_output.append(f"*Found {len(high_corr_pairs)} pairs with absolute correlation > {CORRELATION_THRESHOLD} (showing top 50):*"); markdown_output.append("```")
                          markdown_output.append(high_corr_pairs.head(50).to_string()); markdown_output.append("```\n")
                     else: markdown_output.append(f"*No pairs found with absolute correlation > {CORRELATION_THRESHOLD}.*\n")
                else: markdown_output.append("\n*Not enough numeric columns (>=2) to calculate correlation.*\n")
            except Exception as e_corr: logging.warning(f"Could not calculate correlations: {e_corr}"); markdown_output.append("\n*Could not calculate correlations.*\n")


            # --- Data Sample (Random Rows, ALL Columns) ---
            markdown_output.append(f"\n### Data Sample (Random Rows, All Columns)\n")

            if num_cols == 0 or num_rows == 0:
                markdown_output.append(f"* Cannot display sample: DataFrame has {num_rows} rows and {num_cols} columns.*\n")
            else:
                rows_to_sample = min(NUM_RANDOM_ROWS_TALL, num_rows)
                markdown_output.append(f"*Showing **{rows_to_sample} random rows (Time Points / Observations)** across **all {num_cols} columns (Series / Attributes)**.*\n")
                markdown_output.append(f"**Warning:** This table might be very wide and may not render well in all viewers.\n")

                try:
                    sampled_row_indices = random.sample(range(num_rows), rows_to_sample)
                    # Select sampled rows and ALL columns
                    df_sample_display = df.iloc[sorted(sampled_row_indices), :] # Use ':' for all columns

                    markdown_output.append("```markdown")
                    markdown_output.append(df_sample_display.to_markdown(index=True)) # Show index (time/obs)
                    markdown_output.append("```\n")
                except Exception as e_sample:
                     logging.error(f"Error creating data sample for {filename}: {e_sample}")
                     markdown_output.append(f"*Could not generate data sample (Error: {e_sample}).*\n")


            markdown_output.append("\n---\n") # Separator between files

        # --- Error Handling ---
        except FileNotFoundError: logging.error(f"File not found error for {filepath}"); markdown_output.append(f"### Error Reading File\n```\nFile not found at: {filepath}\n```\n"); markdown_output.append("\n---\n")
        except pd.errors.EmptyDataError: logging.warning(f"File {filename} is empty."); markdown_output.append(f"### Basic Information\n* File `{filename}` is empty.*\n"); markdown_output.append("\n---\n") # Use Basic Info section title
        except Exception as e: logging.error(f"Unexpected error processing {filename}: {e}", exc_info=True); markdown_output.append(f"### Error During Processing\n"); markdown_output.append(f"An unexpected error occurred for `{filename}`. Check logs.\n"); markdown_output.append(f"```\n{e}\n```\n"); markdown_output.append("\n---\n")

    return "\n".join(markdown_output)


# --- Main Execution ---
if __name__ == "__main__":
    logging.info("Starting CSV analysis script (Assuming Tall Format, Comprehensive).")
    logging.info(f"Script location: {CURRENT_DIR}")
    logging.info(f"Data directory: {DATA_DIR_PATH}")
    logging.info(f"Metadata file: {os.path.join(CURRENT_DIR, METADATA_FILE)}")
    logging.info(f"Output file: {os.path.join(CURRENT_DIR, OUTPUT_FILE)}")
    logging.info(f"Row display sample: Random {NUM_RANDOM_ROWS_TALL}")
    logging.info(f"Correlation threshold: {CORRELATION_THRESHOLD}")

    metadata_filepath = os.path.join(CURRENT_DIR, METADATA_FILE)
    metadata = parse_metadata(metadata_filepath)
    if metadata is None: logging.warning(f"Proceeding without metadata."); metadata = {}

    markdown_content = process_csv_files(CURRENT_DIR, DATA_DIR_PATH, metadata)

    output_path = os.path.join(CURRENT_DIR, OUTPUT_FILE)
    try: # File writing
        with open(output_path, 'w', encoding='utf-8') as f: f.write(markdown_content)
        logging.info(f"Successfully generated comprehensive summary report: {output_path}")
    except Exception as e: logging.error(f"Failed to write output file {output_path}: {e}")

    logging.info("Script finished.")
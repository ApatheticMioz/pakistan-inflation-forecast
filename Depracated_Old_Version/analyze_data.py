import pandas as pd
import os
import re
import io
import logging
from datetime import datetime
import warnings
import numpy as np

# --- Configuration ---
OUTPUT_FILE = 'data_summary_v6_user_list.md' # Updated output filename
# DATA_SUBDIRECTORY = 'Data' # Assuming data is in the 'Data' subdirectory relative to the script

# Analysis Parameters
CORRELATION_THRESHOLD = 0.8 # Threshold for reporting correlated column pairs
TOP_N_VALUE_COUNTS = 20     # Number of top values to show in value_counts
MAX_COLS_VALUE_COUNTS = 50  # Max number of object columns to show value counts for
COMMON_NA_VALUES = ['..', '...', '-', 'na', 'n/a', '', ' ', 'none', 'null'] # Common NA representations

# Paths
CURRENT_DIR = os.getcwd() # Use current working directory
DATA_DIR_PATH = os.path.join(CURRENT_DIR, "Data") # Look inside the Data folder

# --- User Specified Wide Files ---
# List of filenames the user explicitly wants treated as wide
user_wide_files = [
    "capital_markets_and_corporate_sector.csv",
    "agriculture.csv",
    "economic_and_social_indicators.csv",
    "education.csv",
    "fiscal_development.csv",
    "growth_and_investment.csv",
    "health_and_nutrition.csv",
    "inflation.csv", # User added this, overriding potential Tall classification
    "information_technology_and_telecommunication.csv",
    "manufacturing_and_mining.csv",
    "money_and_credit.csv",
    "public_debt.csv",
    "population,_labor_force_and_employment.csv", # Note the comma in filename
    "social_protection.csv",
    "trade_partner_inflations.csv",
    "transport_and_communications.csv",
    "energy.csv"
]


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
    verbose_setting = True
    if df.shape[1] > 100:
        verbose_setting = None

    try:
        df.info(buf=buffer, verbose=verbose_setting, show_counts=True, memory_usage=mem_usage)
        info_str = buffer.getvalue()
    except Exception as e:
        logging.warning(f"Could not generate full df.info: {e}")
        buffer = io.StringIO()
        df.info(buf=buffer, verbose=False, show_counts=True, memory_usage=False) # Fallback
        info_str = buffer.getvalue()
        info_str += "\n(Note: Verbose info generation failed, showing basic info)"

    return info_str

# --- Helper Function: Aggregate Summary for Columns ---
def get_column_summary(df):
    """Calculates aggregate statistics for each column in the DataFrame."""
    if df.empty:
        return pd.DataFrame()

    summary = pd.DataFrame(index=df.columns)
    summary['DataType'] = df.dtypes.astype(str)
    summary['NonNullCount'] = df.count()
    summary['NullCount'] = df.isnull().sum()
    summary['NullPct'] = (df.isnull().sum() / len(df) * 100) if len(df) > 0 else 0
    summary['UniqueCount'] = df.nunique()

    numeric_cols = df.select_dtypes(include=np.number).columns
    datetime_cols = df.select_dtypes(include='datetime').columns

    # --- Numeric Stats ---
    numeric_stats_cols = ['Mean', 'StdDev', 'Min', '25%', '50%', '75%', 'Max', 'Skewness', 'Kurtosis']
    for stat_col in numeric_stats_cols:
        summary[stat_col] = pd.NA # Initialize

    if not numeric_cols.empty:
        desc = df[numeric_cols].describe(percentiles=[.25, .5, .75]).T
        summary.loc[numeric_cols, 'Mean'] = desc['mean']
        summary.loc[numeric_cols, 'StdDev'] = desc['std']
        summary.loc[numeric_cols, 'Min'] = desc['min']
        summary.loc[numeric_cols, '25%'] = desc['25%']
        summary.loc[numeric_cols, '50%'] = desc['50%']
        summary.loc[numeric_cols, '75%'] = desc['75%']
        summary.loc[numeric_cols, 'Max'] = desc['max']
        try: summary.loc[numeric_cols, 'Skewness'] = df[numeric_cols].skew(skipna=True)
        except (TypeError, ValueError) as e_skew: summary.loc[numeric_cols, 'Skewness'] = 'Error'
        try: summary.loc[numeric_cols, 'Kurtosis'] = df[numeric_cols].kurt(skipna=True)
        except (TypeError, ValueError) as e_kurt: summary.loc[numeric_cols, 'Kurtosis'] = 'Error'

    # --- Datetime Stats ---
    datetime_stats_cols = ['MinDate', 'MaxDate']
    for dt_col in datetime_stats_cols:
        summary[dt_col] = pd.NaT

    if not datetime_cols.empty:
        summary.loc[datetime_cols, 'MinDate'] = df[datetime_cols].min(skipna=True)
        summary.loc[datetime_cols, 'MaxDate'] = df[datetime_cols].max(skipna=True)

    # --- First/Last Non-Null ---
    try:
        if not df.empty:
             summary['FirstNonNull'] = df.apply(lambda col: col.dropna().iloc[0] if col.dropna().shape[0] > 0 else pd.NA, axis=0)
             summary['LastNonNull'] = df.apply(lambda col: col.dropna().iloc[-1] if col.dropna().shape[0] > 0 else pd.NA, axis=0)
        else:
             summary['FirstNonNull'] = pd.NA
             summary['LastNonNull'] = pd.NA
    except Exception as e:
        logging.warning(f"Could not reliably determine first/last non-null values: {e}")
        summary['FirstNonNull'] = 'Error'
        summary['LastNonNull'] = 'Error'

    # --- Formatting ---
    summary['NullPct'] = summary['NullPct'].map('{:.2f}%'.format)
    for col in numeric_stats_cols:
        if col in summary.columns:
             summary[col] = summary[col].apply(lambda x: f"{x:.3f}" if pd.notna(x) and isinstance(x, (int, float, np.number)) else x)
             summary[col] = summary[col].fillna('N/A')

    # --- Define final column order ---
    all_expected_cols = [
        'DataType', 'NonNullCount', 'NullCount', 'NullPct', 'UniqueCount',
        'Mean', 'StdDev', 'Min', '25%', '50%', '75%', 'Max',
        'Skewness', 'Kurtosis', 'MinDate', 'MaxDate', 'FirstNonNull', 'LastNonNull'
    ]
    for exp_col in all_expected_cols:
        if exp_col not in summary.columns:
            summary[exp_col] = 'N/A'
    summary = summary[all_expected_cols]

    return summary

# --- Helper Function: Find Header Row ---
def find_header_row(filepath, encoding='utf-8', max_lines=20):
    """Tries to find the header row index by looking for patterns."""
    try:
        with open(filepath, 'r', encoding=encoding) as f:
            lines = [f.readline() for _ in range(max_lines)]

        # Pattern 1: Look for standard header keywords
        keywords = ['date', 'series', 'value', 'sector', 'indicator', 'country', 'year', 'month', 'quarter']
        for i, line in enumerate(lines):
            line_lower = line.lower()
            cells = [c.strip('" ').lower() for c in line.strip().split(',')[:10]]
            if sum(keyword in line_lower for keyword in keywords) >= 2 or \
               ('sectors' in cells and 'sub-sectors-level1' in cells) or \
               ('observation date' in cells and 'observation value' in cells):
                if i + 1 < len(lines):
                     next_line_cells = lines[i+1].strip().split(',')
                     if next_line_cells and (next_line_cells[0].strip('" ').replace('.','',1).isdigit() or \
                                             re.match(r'^[0-9]{4}[M-]?[0-9]{2}', next_line_cells[0].strip('" '))):
                         return i

        # Pattern 2 (Wide Format Heuristic)
        for i, line in enumerate(lines):
            cells = [c.strip('" ') for c in line.strip().split(',')[:5]]
            if not cells: continue
            first_cell = cells[0]
            is_date_like = re.match(r"^[0-9]{4}M[0-9]{2}$", first_cell) or \
                           re.match(r"^[0-9]{4}-[0-9]{2}$", first_cell) or \
                           re.match(r"^[0-9]{4}$", first_cell)
            if is_date_like and len(cells) > 1 and cells[1] and not re.fullmatch(r"[0-9.,\- ]+", cells[1]):
                if i > 0:
                     prev_line_cells = lines[i-1].strip().split(',')[:5]
                     if len(prev_line_cells) < 2 or not prev_line_cells[1].strip('" '):
                         return i
                else:
                     return i

    except Exception as e:
        logging.warning(f"Error finding header row in {filepath}: {e}")
    return 0


# --- Main Processing Function ---
def process_csv_files(data_dir, user_wide_files):
    """ Processes CSV files, prioritizing user list for wide format, then shape, then tall."""
    markdown_output = []
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    markdown_output.append(f"# Data Summary Report (v6 - User List Priority)") # Updated title
    markdown_output.append(f"Generated on: {current_time}")
    markdown_output.append("\n---\n")
    markdown_output.append("## Overview")
    markdown_output.append(f"This report summarizes CSV datasets found in the directory: `{data_dir}`.")
    markdown_output.append(f"**Processing Approach:** The script reads each CSV.")
    markdown_output.append(f"  * **User Specified Wide:** If the filename is in the predefined `user_wide_files` list, it's treated as **Wide** and **transposed**.")
    markdown_output.append(f"  * **Shape-Based Wide:** If not in the user list AND `columns > rows`, it's treated as **Wide** based on shape and **transposed**.")
    markdown_output.append(f"  * **Tall:** Otherwise, the file is treated as **Tall** and analyzed in its original format.")
    markdown_output.append(f"Transposition (when applied) uses the first original column as the new index (series names), and original column headers (time periods) become the new row index.")
    markdown_output.append(f"Type conversion (to numeric/datetime) is attempted after determining the format.")
    markdown_output.append(f"**Content:** Includes processing notes (indicating format handling: User Wide, Shape Wide, or Tall), original column names, basic info, memory usage, missing values, unique values, value counts, distribution stats, date analysis (if applicable), correlation summary, and a **detailed summary table for the columns being analyzed**.")
    markdown_output.append("\n---\n")

    if not os.path.isdir(data_dir):
        logging.error(f"Data directory not found: {data_dir}")
        markdown_output.append(f"**Error:** Data directory `{data_dir}` not found.")
        return "\n".join(markdown_output)

    logging.info(f"Looking for CSV files in: {data_dir}")
    try:
        all_files = os.listdir(data_dir)
        found_csv_files = sorted([f for f in all_files if f.lower().endswith('.csv') and not f.startswith('~$') and not f.startswith('.') and os.path.isfile(os.path.join(data_dir, f))])
    except Exception as e:
        logging.error(f"Error listing files in {data_dir}: {e}")
        markdown_output.append(f"**Error:** Could not list files in `{data_dir}`: {e}")
        return "\n".join(markdown_output)

    logging.info(f"Found {len(found_csv_files)} CSV files.")
    if not found_csv_files:
        markdown_output.append(f"No CSV files found in directory: `{data_dir}`")
        return "\n".join(markdown_output)

    # --- Main Loop ---
    for filename in found_csv_files:
        filepath = os.path.join(data_dir, filename)
        logging.info(f"--- Processing file: {filename} ---")
        markdown_output.append(f"\n## Analysis for: `{filename}`\n")

        df_orig = None
        df_processed = None
        processing_notes = []
        original_shape = None
        original_cols = []
        analysis_target = "Original Columns"
        file_encoding = 'utf-8' # Default encoding
        transpose_reason = None # To store why transposition was chosen

        # --- Step 1: Read the file ---
        try:
            header_row_index = find_header_row(filepath, encoding=file_encoding)
            try:
                df_orig = pd.read_csv(filepath, header=header_row_index, low_memory=False, na_values=COMMON_NA_VALUES, encoding=file_encoding)
            except UnicodeDecodeError:
                logging.warning(f"UTF-8 reading failed for {filename} (header={header_row_index}). Trying 'latin1'.")
                file_encoding = 'latin1'
                header_row_index = find_header_row(filepath, encoding=file_encoding)
                df_orig = pd.read_csv(filepath, header=header_row_index, encoding=file_encoding, low_memory=False, na_values=COMMON_NA_VALUES)

            df_orig.dropna(axis=0, how='all', inplace=True)
            df_orig.dropna(axis=1, how='all', inplace=True)

        except Exception as e_read:
             logging.error(f"Failed to read {filename}: {e_read}", exc_info=True)
             markdown_output.append(f"### Error Reading File\n```\n{e_read}\n```\n")
             markdown_output.append("\n---\n")
             continue

        if df_orig is None or df_orig.empty:
             logging.warning(f"File {filename} is empty or effectively empty after read. Skipping.")
             markdown_output.append("### Processing Notes & Columns\n* File appears empty or failed to load fully. Skipping detailed analysis.*\n")
             markdown_output.append(f"\n* **Original Column Names (0):**\n  ```\n  []\n  ```")
             markdown_output.append("\n---\n")
             continue

        original_shape = df_orig.shape
        original_cols = df_orig.columns.tolist()
        processing_notes.append(f"* **Original Shape (after header detection & cleaning):** {original_shape} (rows, columns)")

        # --- Step 2: Determine Format (User List -> Shape -> Tall) ---
        rows, cols = original_shape
        should_transpose = False

        if filename in user_wide_files:
            should_transpose = True
            transpose_reason = "User specified as Wide"
        elif cols > rows and rows > 0: # Check shape only if not in user list
            should_transpose = True
            transpose_reason = f"Shape detected as Wide (Cols={cols} > Rows={rows})"

        # --- Attempt WIDE processing if should_transpose is True ---
        if should_transpose:
            processing_notes.append(f"* **Format:** Treating as **Wide** ({transpose_reason}). Transposing.")
            analysis_target = "Transposed Columns (Original First Col as Index)"
            try:
                if not original_cols: raise ValueError("Cannot transpose, no columns found after read.")
                # Assume first column contains the series identifiers/names
                # Handle potential multi-level columns read initially - flatten if needed?
                if isinstance(original_cols[0], tuple):
                     index_col_name = original_cols[0][0] # Take first level if tuple
                     logging.warning(f"Detected tuple column name '{original_cols[0]}', using '{index_col_name}' for index.")
                else:
                     index_col_name = original_cols[0]

                processing_notes.append(f"* Using original column `{index_col_name}` as index for transposition.")

                if index_col_name not in df_orig.columns:
                     # Maybe the header row finding was imperfect, try first positional column name
                     index_col_name = df_orig.columns[0]
                     processing_notes.append(f"* Warning: Original identified index '{original_cols[0]}' not found. Falling back to first positional column `{index_col_name}` for index.")
                     if index_col_name not in df_orig.columns: # Still not found?
                         raise ValueError(f"Cannot find suitable index column for transposition. Columns: {df_orig.columns.tolist()}")

                # Identify potential multi-index columns *before* setting index
                id_vars = [col for col in df_orig.columns if not re.match(r'^[0-9]{4}(-[0-9]{2})?M?[0-9]{0,2}$', str(col)) and col != index_col_name][:3] # Max 3 ID columns besides the main one
                if not id_vars: id_vars = [index_col_name] # Use only the primary one if others don't fit pattern
                else: id_vars = [index_col_name] + id_vars
                processing_notes.append(f"* Identified potential identifier columns: {id_vars}")


                df_temp = df_orig.set_index(id_vars)
                df_processed = df_temp.T # Transpose
                df_processed.index.name = 'TimePeriod'

                processing_notes.append(f"* **Transposition Successful.**")

                # Attempt index conversion (numeric/datetime)
                try:
                    original_col_names = df_processed.index.astype(str)
                    numeric_index = pd.to_numeric(original_col_names, errors='coerce')
                    datetime_index_m = pd.to_datetime(original_col_names.str.replace('M','-'), errors='coerce', format='%Y-%m')
                    datetime_index_y = pd.to_datetime(original_col_names.str[:4], errors='coerce', format='%Y')

                    if datetime_index_m.notna().all(): df_processed.index = datetime_index_m; note = "datetime64[ns] (YYYY-MM format)"
                    elif numeric_index.notna().all() and numeric_index.nunique() > 1: df_processed.index = numeric_index; note = f"{df_processed.index.dtype} (likely years)"
                    elif datetime_index_y.notna().all(): df_processed.index = datetime_index_y; note = "datetime64[ns] (YYYY format)"
                    else: note = f"object (kept as {df_processed.index.dtype})"
                    processing_notes.append(f"* Transposed index converted to: {note}")
                except Exception as e_idx_conv: processing_notes.append(f"* Warning: Error converting transposed index: {e_idx_conv}")

                # Attempt data conversion to numeric
                processing_notes.append("* Attempting conversion of data to numeric...")
                try:
                    # Identify columns that are *not* purely NA before applying
                    cols_to_convert = df_processed.columns[df_processed.notna().any()]
                    df_processed[cols_to_convert] = df_processed[cols_to_convert].apply(pd.to_numeric, errors='coerce', axis=0)
                    processing_notes.append("* Data conversion to numeric attempted.")
                except Exception as e_numeric_conv:
                    logging.error(f"Failed bulk numeric conversion for transposed {filename}: {e_numeric_conv}")
                    processing_notes.append(f"* Warning: Bulk numeric conversion failed: {e_numeric_conv}. Data types may be mixed.")

            except Exception as e_wide:
                logging.error(f"Error during WIDE processing/transposition for {filename}: {e_wide}", exc_info=True)
                processing_notes.append(f"* **Transposition FAILED:** {e_wide}. Analyzing original format.")
                df_processed = df_orig.copy() # Revert to original
                analysis_target = "Original Columns (Transposition Failed)"
                # Apply generic conversion to original tall format as fallback
                processing_notes.append("* Applying generic type conversion to original format...")
                for col in df_processed.columns:
                     if 'date' in str(col).lower():
                          try: df_processed[col] = pd.to_datetime(df_processed[col], errors='coerce')
                          except: pass
                     elif df_processed[col].dtype == 'object':
                          try:
                              converted = pd.to_numeric(df_processed[col], errors='coerce')
                              if converted.notna().sum() > 0: df_processed[col] = converted
                          except: pass

        # --- Treat as TALL if not transposed ---
        else:
             processing_notes.append(f"* **Format:** Treating as **Tall** (Not in user Wide list and Rows={rows} >= Cols={cols}). Analyzing original format.")
             df_processed = df_orig.copy()
             analysis_target = "Original Columns"
             # Apply generic type conversion attempts
             processing_notes.append("* Applying generic type conversion...")
             converted_types_log = []
             for col in df_processed.columns:
                  original_dtype = str(df_processed[col].dtype)
                  # Attempt date conversion first
                  if 'date' in str(col).lower() or 'month' in str(col).lower() or 'period' in str(col).lower():
                      try:
                          converted_series = pd.to_datetime(df_processed[col], errors='coerce')
                          if converted_series.notna().mean() > 0.5 and not pd.api.types.is_datetime64_any_dtype(original_dtype):
                              df_processed[col] = converted_series
                              converted_types_log.append(f"`{col}`: {original_dtype} -> datetime64")
                              continue
                      except Exception: pass

                  # Attempt numeric conversion
                  if df_processed[col].dtype == 'object' or any(kw in str(col).lower() for kw in ['value', 'rate', 'index', 'amount', 'rs', 'usd', 'yield', 'gdp', 'cpi', 'wpi']):
                      try:
                          if df_processed[col].dtype == 'object':
                             cleaned_series = df_processed[col].astype(str).str.replace(',', '', regex=False)
                             converted_series = pd.to_numeric(cleaned_series, errors='coerce')
                          else:
                             converted_series = pd.to_numeric(df_processed[col], errors='coerce')

                          if converted_series.notna().mean() > 0.5 and not pd.api.types.is_numeric_dtype(original_dtype):
                              df_processed[col] = converted_series
                              converted_types_log.append(f"`{col}`: {original_dtype} -> {df_processed[col].dtype}")
                      except Exception as e_num_conv:
                           logging.debug(f"Numeric conversion skipped for column {col}: {e_num_conv}")

             if converted_types_log: processing_notes.append("* Type Conversions Applied: " + ", ".join(converted_types_log))
             else: processing_notes.append("* No significant type conversions applied.")


        # --- Step 3: Analysis (on df_processed) ---
        if df_processed is None:
             logging.error(f"df_processed is None for {filename}. Skipping analysis.")
             markdown_output.append("### Error\n*Failed to prepare data for analysis. Skipping.*\n")
             markdown_output.append("\n---\n")
             continue

        final_shape = df_processed.shape
        num_rows, num_cols = final_shape
        processing_notes.append(f"* **Shape Analyzed:** {final_shape} (rows, columns)")

        markdown_output.append("### Processing Notes & Columns\n")
        markdown_output.append("\n".join(processing_notes))
        markdown_output.append(f"\n* **Original Column Names ({len(original_cols)}):**\n  ```\n  {original_cols}\n  ```")
        if analysis_target.startswith("Transposed"):
             # Handle potential MultiIndex columns after transpose
             analyzed_cols_list = df_processed.columns.tolist()
             if isinstance(df_processed.columns, pd.MultiIndex):
                 analyzed_cols_list = ['_'.join(map(str, col)).strip() for col in analyzed_cols_list] # Join tuple levels
             markdown_output.append(f"\n* **Analyzed Column Names (Original Series Identifiers) ({len(analyzed_cols_list)}):**\n  ```\n  {analyzed_cols_list}\n  ```")


        # --- Standard Analysis Sections ---
        markdown_output.append("\n### Basic Information (Analyzed Data)\n")
        markdown_output.append(f"* **Total Cells:** {df_processed.size:,}")
        try: markdown_output.append(f"* **Data Types Summary:** {dict(df_processed.dtypes.value_counts())}")
        except Exception as e_dtype: markdown_output.append(f"* Data Types Summary: Error ({e_dtype})")


        # Memory Usage
        try:
            mem_usage = df_processed.memory_usage(deep=True, index=True)
            markdown_output.append("\n### Memory Usage (Bytes)\n")
            markdown_output.append(f"* **Total:** {mem_usage.sum():,} Bytes")
            markdown_output.append(f"* **Per Analyzed Column + Index:**"); markdown_output.append("```")
            if len(mem_usage) > 100:
                 markdown_output.append(mem_usage.head(50).to_string(float_format='{:,.0f}'.format)); markdown_output.append("\n...\n"); markdown_output.append(mem_usage.tail(50).to_string(float_format='{:,.0f}'.format)); markdown_output.append(f"\n(Showing first/last 50 of {len(mem_usage)} entries)")
            else: markdown_output.append(mem_usage.to_string(float_format='{:,.0f}'.format))
            markdown_output.append("```\n")
        except Exception as e_mem: logging.warning(f"Could not get detailed memory usage for {filename}: {e_mem}"); markdown_output.append("\n*Could not retrieve detailed memory usage.*\n")

        # DataFrame Info Summary
        markdown_output.append("\n### DataFrame Info Summary (Analyzed Data)\n")
        markdown_output.append(f"```\n{get_df_info_string(df_processed)}\n```\n")

        # Datetime Analysis
        date_series_dt = None
        date_source_name = None
        if pd.api.types.is_datetime64_any_dtype(df_processed.index):
            date_series_dt = df_processed.index.to_series()
            date_source_name = f"Index ({df_processed.index.name or 'Unnamed'})"
        else:
            dt_cols = df_processed.select_dtypes(include=['datetime', 'datetime64[ns]', 'datetimetz']).columns
            if not dt_cols.empty:
                date_col_to_analyze = dt_cols[0]
                date_series_dt = df_processed[date_col_to_analyze]
                date_source_name = f"Column `{date_col_to_analyze}`"

        if date_series_dt is not None and date_source_name is not None:
             markdown_output.append(f"\n### Date Analysis ({date_source_name})\n")
             try:
                 if date_series_dt.notna().any():
                     date_series = date_series_dt.dropna().sort_values()
                     markdown_output.append(f"* **Data Type:** {date_series_dt.dtype}")
                     try: markdown_output.append(f"* **Min Date:** {date_series.min()}")
                     except TypeError: markdown_output.append("* **Min Date:** Error (mixed types?)")
                     try: markdown_output.append(f"* **Max Date:** {date_series.max()}")
                     except TypeError: markdown_output.append("* **Max Date:** Error (mixed types?)")
                     markdown_output.append(f"* **Number of Unique Dates:** {date_series.nunique()}")
                     inferred_freq = None
                     # Use the original series/index for frequency inference
                     if isinstance(date_series_dt, pd.DatetimeIndex) or pd.api.types.is_datetime64_any_dtype(date_series_dt.dtype) and len(date_series_dt.dropna()) > 2:
                        try: inferred_freq = pd.infer_freq(date_series_dt.dropna().sort_values()); markdown_output.append(f"* **Inferred Frequency:** {inferred_freq or 'None'}")
                        except ValueError: markdown_output.append(f"* **Inferred Frequency:** Error inferring")
                     else: markdown_output.append(f"* **Inferred Frequency:** N/A")
                     if inferred_freq:
                        try:
                           expected_range = pd.date_range(start=date_series.min(), end=date_series.max(), freq=inferred_freq)
                           missing_dates = len(expected_range.difference(pd.DatetimeIndex(date_series.unique())))
                           markdown_output.append(f"* **Missing Dates (based on inferred freq):** {missing_dates}")
                        except Exception as e_missing: markdown_output.append(f"* **Missing Dates:** Error calculating ({e_missing})")
                     else: markdown_output.append("* **Missing Dates:** Could not infer frequency.")
                     duplicates = date_series_dt.duplicated().sum()
                     markdown_output.append(f"* **Duplicate Dates:** {duplicates}{' (Potential issue!)' if duplicates > 0 else ''}")
                     markdown_output.append("\n")
                 else: markdown_output.append(f"*Source '{date_source_name}' contains no valid date values.*\n")
             except Exception as e_dt_col: logging.warning(f"Error during date analysis for {date_source_name} in {filename}: {e_dt_col}"); markdown_output.append("*Error during date analysis.*\n")

        # Missing Values Summary
        markdown_output.append(f"\n### Missing Values Summary (per Analyzed Column)\n")
        try:
             missing_values = df_processed.isnull().sum(); missing_total = missing_values.sum(); missing_pct = missing_total / df_processed.size if df_processed.size > 0 else 0
             missing_values_filtered = missing_values[missing_values > 0].sort_values(ascending=False)
             markdown_output.append(f"Total missing values: {missing_total:,} ({missing_pct:.2%})")
             if not missing_values_filtered.empty:
                 markdown_output.append(f"Columns ({len(missing_values_filtered)} of {num_cols}) with missing values (Sorted):"); markdown_output.append("```")
                 markdown_output.append(missing_values_filtered.to_string()); markdown_output.append("```\n")
             else: markdown_output.append("* No missing values found.*\n")
        except Exception as e_missing: logging.warning(f"Could not compute missing values for {filename}: {e_missing}"); markdown_output.append("*Error calculating missing values.*\n")


        # Unique Values Summary
        markdown_output.append(f"\n### Unique Values per Analyzed Column (Sample)\n")
        try:
            unique_counts = df_processed.nunique(); markdown_output.append(f"Showing unique counts for first/last 10 analyzed columns (Total columns: {num_cols}):"); markdown_output.append("```")
            if len(unique_counts) > 20: markdown_output.append(unique_counts.head(10).to_string()); markdown_output.append("\n...\n"); markdown_output.append(unique_counts.tail(10).to_string())
            else: markdown_output.append(unique_counts.to_string())
            markdown_output.append("```\n")
        except Exception as e_unique: logging.warning(f"Could not compute unique values for {filename}: {e_unique}"); markdown_output.append("*Error calculating unique values.*\n")


        # Value Counts for Object Columns
        try:
            object_cols = df_processed.select_dtypes(include=['object', 'category']).columns
            if not object_cols.empty:
                markdown_output.append(f"\n### Value Counts for Categorical/Object Columns (Top {TOP_N_VALUE_COUNTS})\n"); markdown_output.append(f"*Showing top {TOP_N_VALUE_COUNTS} values for up to {MAX_COLS_VALUE_COUNTS} columns.*\n")
                cols_to_show_counts = object_cols[:MAX_COLS_VALUE_COUNTS]
                for col in cols_to_show_counts:
                    try:
                        cleaned_col = df_processed[col].dropna()
                        is_hashable = True
                        if not cleaned_col.empty:
                            try: hash(cleaned_col.iloc[0])
                            except TypeError: is_hashable = False

                        if not is_hashable:
                             logging.warning(f"Column '{col}' in {filename} contains non-hashable types, skipping value counts.")
                             markdown_output.append(f"**Column: `{col}`**\n*Skipping value counts due to non-hashable types.*\n")
                             continue

                        counts = cleaned_col.value_counts()
                        unique_count_col = counts.size
                        markdown_output.append(f"**Column: `{col}`** (Top {min(TOP_N_VALUE_COUNTS, len(counts))} of {unique_count_col} unique values)")
                        markdown_output.append("```"); markdown_output.append(counts.head(TOP_N_VALUE_COUNTS).to_string()); markdown_output.append("```")
                    except Exception as e_vc_inner:
                         logging.warning(f"Could not generate value counts for column {col} in {filename}: {e_vc_inner}")
                         markdown_output.append(f"**Column: `{col}`**\n*Could not generate value counts.*\n")

                if len(object_cols) > MAX_COLS_VALUE_COUNTS: markdown_output.append(f"\n*... (Value counts for remaining {len(object_cols) - MAX_COLS_VALUE_COUNTS} object columns not shown)*")
                markdown_output.append("\n")
        except Exception as e_vc: logging.warning(f"Could not generate value counts for {filename}: {e_vc}"); markdown_output.append("\n*Could not generate value counts.*\n")


        # --- Aggregate Summary Table ---
        markdown_output.append(f"\n### Analyzed Column Summary Table (Stats per Column: {analysis_target})\n")
        try:
            column_summary_df = get_column_summary(df_processed)
            if not column_summary_df.empty:
                markdown_output.append("```markdown")
                with pd.option_context('display.max_colwidth', None, 'display.width', 1000):
                    markdown_output.append(column_summary_df.to_markdown())
                markdown_output.append("```\n")
            else:
                 markdown_output.append("*Could not generate column summary table (Empty DataFrame?).*\n")
        except Exception as e_agg:
             logging.error(f"Failed to generate column summary table for {filename}: {e_agg}", exc_info=True)
             markdown_output.append(f"*Could not generate column summary table (Error: {e_agg}). Check logs.*\n")


        # --- Correlation Summary ---
        try:
            numeric_cols = df_processed.select_dtypes(include=np.number).columns
            if len(numeric_cols) >= 2:
                 markdown_output.append(f"\n### High Correlation Pairs (|Correlation| > {CORRELATION_THRESHOLD} between Numeric Analyzed Columns)\n")
                 try: corr_matrix = df_processed[numeric_cols].corr(method='pearson')
                 except Exception as e_corr_calc: raise ValueError(f"Correlation calculation failed: {e_corr_calc}")

                 corr_matrix_abs = corr_matrix.abs()
                 upper_tri = corr_matrix_abs.where(np.triu(np.ones(corr_matrix_abs.shape), k=1).astype(bool))
                 high_corr_sr = upper_tri[upper_tri > CORRELATION_THRESHOLD].stack()

                 if not high_corr_sr.empty:
                      high_corr_sr_sorted = high_corr_sr.sort_values(ascending=False)
                      original_corr_values = high_corr_sr_sorted.index.map(lambda idx: corr_matrix.loc[idx[0], idx[1]])
                      # Handle potential MultiIndex in report generation
                      if isinstance(high_corr_sr_sorted.index, pd.MultiIndex):
                          index_tuples = [(str(idx[0]), str(idx[1])) for idx in high_corr_sr_sorted.index] # Convert tuple elements to str
                          report_index = pd.MultiIndex.from_tuples(index_tuples, names=high_corr_sr_sorted.index.names)
                      else:
                          report_index = high_corr_sr_sorted.index

                      high_corr_report = pd.Series(original_corr_values.to_numpy(), index=report_index) # Use .to_numpy() for safety

                      markdown_output.append(f"*Found {len(high_corr_report)} pairs with absolute correlation > {CORRELATION_THRESHOLD} (showing top 50):*"); markdown_output.append("```")
                      markdown_output.append(high_corr_report.head(50).to_string()); markdown_output.append("```\n")
                 else: markdown_output.append(f"*No pairs found with absolute correlation > {CORRELATION_THRESHOLD}.*\n")
        except Exception as e_corr: logging.warning(f"Could not calculate correlations for {filename}: {e_corr}"); markdown_output.append(f"\n*Could not calculate correlations (Error: {e_corr}).*\n")


        markdown_output.append("\n---\n") # Separator between files

    # --- End of Main Loop ---
    return "\n".join(markdown_output)

# --- Main Execution ---
if __name__ == "__main__":
    script_name = os.path.basename(__file__)
    logging.info(f"Starting CSV analysis script ({script_name}).")
    if not os.path.isdir(DATA_DIR_PATH):
         logging.error(f"CRITICAL ERROR: Data directory does not exist: {DATA_DIR_PATH}")
         print(f"Error: Data directory not found at '{DATA_DIR_PATH}'. Please ensure the 'Data' subdirectory exists relative to the script or CWD.")
    else:
        logging.info(f"Script location (CWD): {CURRENT_DIR}")
        logging.info(f"Data directory: {DATA_DIR_PATH}")
        logging.info(f"Output file: {os.path.join(CURRENT_DIR, OUTPUT_FILE)}")

        markdown_content = process_csv_files(DATA_DIR_PATH, user_wide_files) # Pass the user list

        output_path = os.path.join(CURRENT_DIR, OUTPUT_FILE)
        try:
            with open(output_path, 'w', encoding='utf-8') as f: f.write(markdown_content)
            logging.info(f"Successfully generated comprehensive summary report: {output_path}")
        except Exception as e:
            logging.error(f"Failed to write output file {output_path}: {e}")
            print(f"Error writing output file: {e}")

    logging.info("Script finished.")
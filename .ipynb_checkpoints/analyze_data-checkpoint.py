import pandas as pd
import os
import io
import sys
import traceback
import csv # Import csv module for sniffing

# --- Configuration ---
DATA_DIR = 'Data'  # Subdirectory containing the CSV files
OUTPUT_MD_FILE = 'data_context_summary.md'
SAMPLE_SIZE_HEAD = 50  # Number of rows to show from the start (Adjusted back for typical use)
SAMPLE_SIZE_TAIL = 50  # Number of rows to show from the end (Adjusted back for typical use)
MAX_UNIQUE_VALUES_TO_LIST = 20 # Max unique values to list directly for a column (Adjusted back)
HEADER_CHECK_ROWS = 15 # How many rows to check for a potential header
HEADER_MIN_STR_RATIO = 0.6 # Minimum ratio of string-like cells to guess a row is a header

# --- Helper Functions ---

def get_dataframe_info(df):
    """Captures df.info() output as a string."""
    buffer = io.StringIO()
    df.info(buf=buffer, verbose=True)
    return buffer.getvalue()

def format_unique_values(series, max_unique):
    """Formats unique value information for a column."""
    try:
        # Use nunique() for non-NA unique count
        num_unique = series.nunique()
        # Get actual unique values including NA if present for display
        unique_values_display = series.unique()

        # Check if numeric and has many unique values
        if pd.api.types.is_numeric_dtype(series) and num_unique > max_unique * 2:
            # Safely convert potential non-hashable types (like NaN) to string for display
            sample_list = [str(val) for val in unique_values_display[:5]]
            return f"{num_unique} unique numeric values (excluding NA). (Sample: {sample_list}...)"
        # Check if non-numeric or numeric with moderate unique values
        elif num_unique > max_unique:
            sample_list = [str(val) for val in unique_values_display[:max_unique]]
            return f"{num_unique} unique values (excluding NA). (Sample: {sample_list}...)"
        # Few unique values, list them all
        else:
            value_list = [str(val) for val in unique_values_display]
            return f"{num_unique} unique values (excluding NA): {value_list}"
    except Exception as e:
        return f"Error analyzing unique values: {e}"

def guess_header_row(file_path, n_check=HEADER_CHECK_ROWS, min_str_ratio=HEADER_MIN_STR_RATIO):
    """Tries to guess the header row index within the first n_check rows."""
    detected_header_index = 0 # Default to first row
    try:
        # Read the first few rows without a header
        df_peek = pd.read_csv(file_path, header=None, nrows=n_check, low_memory=False, skip_blank_lines=True)

        potential_headers = {}
        for i, row in df_peek.iterrows():
            not_null_count = row.notna().sum()
            if not_null_count == 0: # Skip completely empty rows
                continue

            # Count cells that look like strings (non-numeric and not purely whitespace)
            str_like_count = 0
            for val in row.dropna(): # Iterate over non-null values only
                try:
                    # Try converting to float, if it fails, it's likely a string
                    float(val)
                except (ValueError, TypeError):
                     # Check if it's not just whitespace
                     if isinstance(val, str) and val.strip():
                         str_like_count += 1
                     elif not isinstance(val, (int, float)): # Catch other non-numeric types
                         str_like_count += 1


            str_ratio = str_like_count / not_null_count if not_null_count > 0 else 0
            potential_headers[i] = str_ratio

            # Simple heuristic: first row with high string ratio might be the header
            if str_ratio >= min_str_ratio:
                # Check if next row has fewer strings (likely data)
                if i + 1 < len(df_peek):
                    next_row = df_peek.iloc[i+1]
                    next_not_null = next_row.notna().sum()
                    if next_not_null > 0:
                        next_str_like = 0
                        for val_next in next_row.dropna():
                             try:
                                 float(val_next)
                             except (ValueError, TypeError):
                                 if isinstance(val_next, str) and val_next.strip():
                                     next_str_like += 1
                                 elif not isinstance(val_next, (int, float)):
                                      next_str_like += 1
                        next_str_ratio = next_str_like / next_not_null
                        # If current row has high str ratio and next has lower, likely header
                        if next_str_ratio < min_str_ratio:
                            detected_header_index = i
                            # print(f"  Detected header at row {i} (Str Ratio: {str_ratio:.2f}, Next Row Ratio: {next_str_ratio:.2f})")
                            return detected_header_index # Return first likely header found

        # If no clear header found by the above logic, maybe just return the row with max string ratio?
        if potential_headers:
             best_guess = max(potential_headers, key=potential_headers.get)
             if potential_headers[best_guess] >= min_str_ratio:
                 # print(f"  Tentative header guess at row {best_guess} (Max Str Ratio: {potential_headers[best_guess]:.2f})")
                 return best_guess


    except pd.errors.EmptyDataError:
        print(f"  Warning: File '{os.path.basename(file_path)}' is empty.")
        return 0 # Return default for empty file
    except Exception as e:
        print(f"  Warning: Error during header detection for '{os.path.basename(file_path)}': {e}. Using default header=0.")
    # print(f"  Could not reliably detect header for '{os.path.basename(file_path)}'. Using default header=0.")
    return 0 # Default if no header confidently detected

# --- Main Script ---

def main():
    """
    Generates a Markdown summary of CSV files in the DATA_DIR.
    """
    script_dir = os.path.dirname(os.path.abspath(__file__))
    data_path = os.path.join(script_dir, DATA_DIR)

    if not os.path.isdir(data_path):
        print(f"Error: Data directory '{data_path}' not found.")
        print(f"Please ensure the script is in the parent directory of '{DATA_DIR}'.")
        sys.exit(1)

    output_file_path = os.path.join(script_dir, OUTPUT_MD_FILE)

    all_files = [f for f in os.listdir(data_path) if f.endswith('.csv') and os.path.isfile(os.path.join(data_path, f))]
    all_files.sort()

    markdown_content = []
    markdown_content.append(f"# Data Context Summary for '{DATA_DIR}' Directory\n")
    markdown_content.append(f"Generated on: {pd.Timestamp.now()}\n")
    markdown_content.append("This document provides a summary, descriptive statistics, and data samples for each CSV file found.")
    markdown_content.append("Use this information alongside your project outline (`Forecasting Pakistan Inflation_ Variables, Methods_.pdf`) to identify relevant datasets and variables.\n")
    markdown_content.append(f"Found {len(all_files)} CSV files to process.\n")
    markdown_content.append("---")

    print(f"Starting data context generation for {len(all_files)} CSV files...")

    for filename in all_files:
        file_path = os.path.join(data_path, filename)
        print(f"Processing: {filename}...")
        markdown_content.append(f"\n## File: `{filename}`\n")
        detected_header_row = 0 # Initialize

        try:
            # --- Auto-detect Header ---
            detected_header_row = guess_header_row(file_path)
            if detected_header_row != 0:
                 markdown_content.append(f"*Note: Automatically detected header at row index {detected_header_row} (0-based).*\n")
            else:
                 markdown_content.append(f"*Note: Using default header row index 0. Verify if correct.*\n")


            # --- Read CSV with detected header ---
            try:
                df = pd.read_csv(file_path, header=detected_header_row, low_memory=False)
            except UnicodeDecodeError:
                try:
                    df = pd.read_csv(file_path, header=detected_header_row, encoding='latin1', low_memory=False)
                    markdown_content.append("*Note: Read using 'latin1' encoding.*\n")
                except UnicodeDecodeError:
                    df = pd.read_csv(file_path, header=detected_header_row, encoding='iso-8859-1', low_memory=False)
                    markdown_content.append("*Note: Read using 'iso-8859-1' encoding.*\n")
                except Exception as read_err:
                    raise ValueError(f"Failed to read CSV '{filename}' with standard encodings: {read_err}")
            except pd.errors.ParserError as parse_err:
                 raise ValueError(f"Failed to parse CSV '{filename}': {parse_err}. Check file structure/delimiters.")
            except Exception as read_err:
                 raise ValueError(f"An unexpected error occurred while reading CSV '{filename}': {read_err}")

            # --- Post-read Processing (Shape, Transpose) ---
            original_shape = df.shape
            markdown_content.append(f"**Shape (after reading header row {detected_header_row}):** {original_shape[0]} rows, {original_shape[1]} columns\n")

            is_wide = original_shape[1] > original_shape[0] and original_shape[0] > 1 # Avoid transposing single row dataframes
            transposed = False
            if is_wide:
                markdown_content.append(f"**Detected Wide Format:** Transposing the DataFrame.\n")
                try:
                    df_transposed = df.T.copy()
                    # Attempt to use the first *column* (which was the first row of the wide data) as the new header
                    # Check if it contains meaningful string headers
                    first_col_values = df_transposed.iloc[:, 0]
                    if first_col_values.apply(lambda x: isinstance(x, str)).mean() > 0.5: # If >50% strings
                        df_transposed.columns = first_col_values
                        df = df_transposed.iloc[:, 1:] # Use all columns except the first as data
                        df.index.name = 'Original_Row_Header' # Name the new index (original row headers)
                    else: # Otherwise, just keep numeric headers and reset index
                         df = df_transposed
                         df.index.name = 'Original_Row_Index'
                         df = df.reset_index() # Make original row index a column

                    markdown_content.append(f"**Transposed Shape:** {df.shape[0]} rows, {df.shape[1]} columns\n")
                    transposed = True
                except Exception as transpose_err:
                    markdown_content.append(f"*Warning: Error during transposition or header setting: {transpose_err}. Proceeding with original shape.*")
                    # Re-read original if transpose failed badly
                    df = pd.read_csv(file_path, header=detected_header_row, low_memory=False)
                    transposed = False

            # --- Generate Context ---
            markdown_content.append("\n### Basic Information & Data Types:\n")
            markdown_content.append("```\n" + get_dataframe_info(df) + "\n```\n")

            markdown_content.append("\n### Descriptive Statistics:\n")
            try:
                desc_stats = df.describe(include='all').transpose()
                markdown_content.append(desc_stats.to_markdown())
            except Exception as desc_err:
                 markdown_content.append(f"*Could not generate descriptive statistics: {desc_err}*")
            markdown_content.append("\n")

            markdown_content.append("\n### Missing Values per Column:\n")
            missing_values = df.isnull().sum()
            missing_values = missing_values[missing_values > 0]
            if not missing_values.empty:
                 markdown_content.append(missing_values.to_frame(name="Missing Count").to_markdown())
            else:
                 markdown_content.append("*No missing values found.*\n")
            markdown_content.append("\n")

            markdown_content.append("\n### Unique Value Analysis (Sample):\n")
            unique_value_summary = []
            cols_to_check = df.columns[:200] if len(df.columns) > 200 else df.columns
            for col in cols_to_check:
                 try:
                    col_dtype = df[col].dtype
                    num_unique = df[col].nunique()
                    # Updated check using isinstance for categorical
                    is_categorical = isinstance(df[col].dtype, pd.CategoricalDtype)
                    is_object = col_dtype == 'object'
                    is_numeric_low_unique = pd.api.types.is_numeric_dtype(col_dtype) and num_unique < MAX_UNIQUE_VALUES_TO_LIST * 2

                    if is_object or is_categorical or is_numeric_low_unique:
                        unique_info = format_unique_values(df[col], MAX_UNIQUE_VALUES_TO_LIST)
                        unique_value_summary.append(f"- **{col}**: {unique_info}")
                 except Exception as unique_err:
                     unique_value_summary.append(f"- **{col}**: Error analyzing unique values: {unique_err}")
            if unique_value_summary:
                markdown_content.extend(unique_value_summary)
            else:
                markdown_content.append("*No specific object/categorical columns identified for unique value sampling based on criteria.*\n")
            markdown_content.append("\n")

            markdown_content.append(f"\n### Data Sample (First {SAMPLE_SIZE_HEAD} and Last {SAMPLE_SIZE_TAIL} Rows):\n")
            if len(df) <= SAMPLE_SIZE_HEAD + SAMPLE_SIZE_TAIL:
                 markdown_content.append(df.to_markdown(index=True))
            else:
                 markdown_content.append("**First Rows:**\n")
                 markdown_content.append(df.head(SAMPLE_SIZE_HEAD).to_markdown(index=True))
                 markdown_content.append("\n**Last Rows:**\n")
                 markdown_content.append(df.tail(SAMPLE_SIZE_TAIL).to_markdown(index=True))
            markdown_content.append("\n")

        except Exception as e:
            print(f"  Error processing {filename}: {e}")
            error_details = traceback.format_exc()
            markdown_content.append(f"\n**ERROR PROCESSING FILE '{filename}':**\n")
            markdown_content.append(f"```\n{str(e)}\n\n{error_details}\n```\n")

        finally:
            markdown_content.append("\n---\n")

    # --- Write Output ---
    try:
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write("\n".join(markdown_content))
        print(f"\nSuccessfully generated data context summary: '{output_file_path}'")
    except Exception as e:
        print(f"\nError writing output file '{output_file_path}': {e}")

if __name__ == "__main__":
    main()

# Script to check the contents of merged_df.rds
merged_df <- readRDS("merged_df.rds")
cat("Column names in merged_df.rds:\n")
cat(paste(names(merged_df), collapse=", "), "\n\n")

# Check for any columns containing "cpi" (case insensitive)
cpi_cols <- grep("cpi", names(merged_df), value = TRUE, ignore.case = TRUE)
cat("Columns containing 'cpi' (case insensitive):\n")
if(length(cpi_cols) > 0) {
  cat(paste(cpi_cols, collapse=", "), "\n\n")
} else {
  cat("No columns containing 'cpi' found\n\n")
}

# Check for inflation-related columns
inflation_cols <- grep("inflation|price|index", names(merged_df), value = TRUE, ignore.case = TRUE)
cat("Columns potentially related to inflation:\n")
if(length(inflation_cols) > 0) {
  cat(paste(inflation_cols, collapse=", "), "\n\n")
} else {
  cat("No inflation-related columns found\n\n")
}

# Print the first few rows of the dataframe
cat("First few rows of merged_df:\n")
print(head(merged_df))

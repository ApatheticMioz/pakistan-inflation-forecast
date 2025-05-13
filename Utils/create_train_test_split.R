# Create train_test_split.rds file
# This script combines the train and test dataframes into a single RDS file

# Load required libraries
suppressPackageStartupMessages({
  library(dplyr)
})

# Create Processed_Data directory if it doesn't exist
dir.create("Processed_Data", showWarnings = FALSE, recursive = TRUE)

# Load train dataframe
if (file.exists("Processed_Data/train_df.rds")) {
  train_df <- readRDS("Processed_Data/train_df.rds")
  message("Loaded train dataframe with ", nrow(train_df), " rows")
} else {
  message("Train dataframe file not found")
  stop("File not found: Processed_Data/train_df.rds")
}

# Load test dataframe
if (file.exists("Processed_Data/test_df.rds")) {
  test_df <- readRDS("Processed_Data/test_df.rds")
  message("Loaded test dataframe with ", nrow(test_df), " rows")
} else {
  message("Test dataframe file not found")
  stop("File not found: Processed_Data/test_df.rds")
}

# Create train_test_split list
train_test_split <- list(
  train = train_df,
  test = test_df
)

# Save train_test_split
saveRDS(train_test_split, "Processed_Data/train_test_split.rds")
message("Saved train_test_split to Processed_Data/train_test_split.rds")

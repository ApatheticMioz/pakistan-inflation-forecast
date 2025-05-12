# 01_load_and_eda.R
# Pakistan Inflation Forecasting Project: Data Loading and EDA
# This script loads all datasets, performs EDA, and saves outputs for further analysis.
# Author: <Your Name>
# Date: 2025-05-13

# --- Set working directory to project root (if running interactively) ---
if (interactive()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}

# Load required libraries
library(readr)
library(dplyr)
library(lubridate)
library(zoo)
library(tidyr)

# Set data directory
main_data_dir <- "Data/data_combined/"

# Load CPI (dependent variable)
cpi <- read_csv(file.path(main_data_dir, "CPI National -YoY.csv"))

# Load exogenous variables
kibor <- read_csv(file.path(main_data_dir, "KIBOR.csv"))
policy_rate <- read_csv(file.path(main_data_dir, "Policy Rate.csv"))
exchange_rate <- read_csv(file.path(main_data_dir, "Pakistan Exchange Rate Per USD.csv"))
exports_imports <- read_csv(file.path(main_data_dir, "Exports and Imports.csv"))
monetary_aggregate <- read_csv(file.path(main_data_dir, "Monthly Monetary Aggregate.csv"))
industrial_production <- read_csv(file.path(main_data_dir, "Industrial Production Index.csv"))
oil_prices <- read_csv(file.path(main_data_dir, "International Oil Prices.csv"))
global_food <- read_csv(file.path(main_data_dir, "Global Food Price Index.csv"))
consumption_investment_gdp <- read_csv(file.path(main_data_dir, "Consumption and Invesment of GDP.csv"))
current_account_balance <- read_csv(file.path(main_data_dir, "Current Account Balance.csv"))
growth_rate <- read_csv(file.path(main_data_dir, "Growth Rate.csv"))
pakistan_share_gdp <- read_csv(file.path(main_data_dir, "Pakistan's Share in GDP.csv"))

datasets <- list(
  cpi = cpi,
  kibor = kibor,
  policy_rate = policy_rate,
  exchange_rate = exchange_rate,
  exports_imports = exports_imports,
  monetary_aggregate = monetary_aggregate,
  industrial_production = industrial_production,
  oil_prices = oil_prices,
  global_food = global_food,
  consumption_investment_gdp = consumption_investment_gdp,
  current_account_balance = current_account_balance,
  growth_rate = growth_rate,
  pakistan_share_gdp = pakistan_share_gdp
)

# Clean column names and parse dates for all datasets
datasets <- lapply(datasets, function(df) {
  df <- df %>% rename_with(~tolower(gsub("[ .-]", "_", .x)))
  if ("date" %in% names(df)) {
    df <- df %>% mutate(date = ymd(date))
  }
  df
})

# Assign cleaned datasets back to variables
cpi <- datasets$cpi
kibor <- datasets$kibor
policy_rate <- datasets$policy_rate
exchange_rate <- datasets$exchange_rate
exports_imports <- datasets$exports_imports
monetary_aggregate <- datasets$monetary_aggregate
industrial_production <- datasets$industrial_production
oil_prices <- datasets$oil_prices
global_food <- datasets$global_food
consumption_investment_gdp <- datasets$consumption_investment_gdp
current_account_balance <- datasets$current_account_balance
growth_rate <- datasets$growth_rate
pakistan_share_gdp <- datasets$pakistan_share_gdp

# --- Source-specific Data Loading Functions ---
load_easydata <- function(filename) {
  df <- readr::read_csv(filename)
  names(df) <- tolower(gsub("[ .-]", "_", names(df)))
  if ("observation_date" %in% names(df)) {
    df$observation_date <- lubridate::dmy(df$observation_date)
  }
  if ("observation_value" %in% names(df)) {
    df$observation_value <- as.numeric(df$observation_value)
  }
  df
}

load_fao <- function(filename) {
  lines <- readLines(filename)
  header_line <- which(grepl("^Date,", lines))[1]
  df <- readr::read_csv(filename, skip = header_line - 1, col_names = TRUE)
  df <- df[!is.na(df$Date) & df$Date != "", ]
  df$Date <- zoo::as.yearmon(df$Date, "%Y-%m")
  for (col in setdiff(names(df), "Date")) {
    df[[col]] <- suppressWarnings(as.numeric(df[[col]]))
  }
  df
}

load_financegovpk <- function(filename) {
  df <- readr::read_csv(filename)
  names(df) <- tolower(gsub("[ .-]", "_", names(df)))
  df
}

load_fred <- function(filename) {
  df <- readr::read_csv(filename)
  names(df) <- tolower(gsub("[ .-]", "_", names(df)))
  if ("observation_date" %in% names(df)) {
    df$observation_date <- lubridate::ymd(df$observation_date)
  }
  for (col in names(df)[-1]) {
    df[[col]] <- as.numeric(df[[col]])
  }
  df
}

load_olddata <- load_easydata

load_all_by_source <- function() {
  easydata_files <- list.files("Data/easydata", full.names = TRUE, pattern = "*.csv")
  easydata <- lapply(easydata_files, load_easydata)
  names(easydata) <- basename(easydata_files)

  fao_files <- list.files("Data/fao", full.names = TRUE, pattern = "*.csv")
  fao <- lapply(fao_files, load_fao)
  names(fao) <- basename(fao_files)

  finance_files <- list.files("Data/finanaceGovPk", full.names = TRUE, pattern = "*.csv")
  financegovpk <- lapply(finance_files, load_financegovpk)
  names(financegovpk) <- basename(finance_files)

  fred_files <- list.files("Data/fred", full.names = TRUE, pattern = "*.csv")
  fred <- lapply(fred_files, load_fred)
  names(fred) <- basename(fred_files)

  olddata_files <- list.files("Data/old_data", full.names = TRUE, pattern = "*.csv")
  old_data <- lapply(olddata_files, load_olddata)
  names(old_data) <- basename(olddata_files)

  list(easydata = easydata, fao = fao, financegovpk = financegovpk, fred = fred, old_data = old_data)
}

all_datasets <- load_all_by_source()

easydata_cpi <- load_easydata("Data/easydata/CPI National -YoY.csv")
fao_food <- load_fao("Data/fao/Global Food Price Index.csv")
finance_gdp <- load_financegovpk("Data/finanaceGovPk/Consumption and Invesment of GDP.csv")
fred_oil <- load_fred("Data/fred/International Oil Prices.csv")

eda_output_file <- "eda_output.txt"
sink(eda_output_file)

dataset_names <- names(datasets)
for (name in dataset_names) {
  cat("\n\n===== ", name, " =====\n")
  print(str(datasets[[name]]))
  print(summary(datasets[[name]]))
  print(head(datasets[[name]]))
  print(tail(datasets[[name]]))
}

describe_datasets <- function(dataset_list, source_name) {
  cat("\n\n==================== ", toupper(source_name), " ====================\n")
  for (name in names(dataset_list)) {
    cat("\n--- ", name, " ---\n")
    print(str(dataset_list[[name]]))
    print(summary(dataset_list[[name]]))
    print(head(dataset_list[[name]]))
    print(tail(dataset_list[[name]]))
  }
}

describe_datasets(all_datasets$easydata, "easydata")
describe_datasets(all_datasets$fao, "fao")
describe_datasets(all_datasets$financegovpk, "finanaceGovPk")
describe_datasets(all_datasets$fred, "fred")
describe_datasets(all_datasets$old_data, "old_data")

sink()
# --- End of EDA output to file ---

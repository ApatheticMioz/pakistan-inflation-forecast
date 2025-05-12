# --- R Data Processing Pipeline Script (v3 - Verified, Full Predictors) ----

# --- 0. Setup ----
# install.packages(c("readr", "dplyr", "lubridate", "tidyr", "zoo", "stringr"))
library(readr)
library(dplyr)
library(lubridate)
library(tidyr)
library(zoo)
library(stringr)

# Paths
base_dir <- "D:/work/Semester4/AdvStats/pakistan-inflation-forecast"
setwd(base_dir)
data_folder <- file.path(base_dir, "Data")
output_folder <- file.path(base_dir, "Processed_Data")

if (!dir.exists(output_folder)) {
  dir.create(output_folder)
  cat("Created output folder:", output_folder, "\n")
}

# Parameters
target_variable_series_name <- ". CPI-YoY-National"
target_variable_file <- "inflation_base_2015.csv"
target_variable_short_name <- "Headline_CPI"

analysis_start_date <- as.Date("2010-01-01")
analysis_end_date <- as.Date("2025-04-30")

common_na_values <- c(
  "", " ", "-", ".", "..", "...", "NA", "#N/A", "N/A", "n/a",
  "NULL", "null", "NaN", "nan", "Missing", "missing",
  "No data", "no data", "?", "<NA>",
  "###", "####", "#####", "######", "#######", "########"
)

cat("Setup Complete. Output will be saved in:", output_folder, "\n")

# --- 1. Define Variables and File Mappings (Verified Version) ----
variable_mapping <- list(
  "Headline_CPI" = list(file = target_variable_file, series_name = target_variable_series_name, freq = "Monthly", type = "target"),
  "Core_NFNE" = list(file = "inflation_base_2015.csv", series_name = ". NFNE-YoY-Urban", freq = "Monthly", type = "predictor"),
  "Core_Trimmed" = list(file = "inflation_base_2015.csv", series_name = ". Trimmed-YoY-Urban", freq = "Monthly", type = "predictor"),
  "M2" = list(file = "m2_broad_money.csv", series_name = "Broad Money (M2) - Total", freq = "Weekly", type = "predictor"),
  "PolicyRate" = list(file = "policy_rate.csv", series_name = "State Bank of Pakistan's Policy (Target) Rate", freq = "Daily", type = "predictor"), # Use Policy Rate
  "KIBOR_3M" = list(file = "kibor_kibid.csv", series_name = "Three-Months Karachi Interbank Offer Rate", freq = "Daily", type = "predictor"), # Adjusted name slightly based on summary
  "PSCredit" = list(file = "money_and_credit.csv", series_name = "Credit To Private Sector", freq = "Monthly", type = "predictor"),
  "PKR_USD_Avg" = list(file = "exchange_rate.csv", series_name = "22 Daily Average Exchange rate of PAK Rupees per U.S. Dollar", freq = "Daily", type = "predictor"), # Adjusted name based on summary
  "REER" = list(file = "REER.csv", series_name = "Real Effective Exchange Rate (Base Year: 2000)", freq = "Monthly", type = "predictor"), # Corrected Series Name based on data_summary
  "GovExp" = list(file = "fiscal_development.csv", series_name = "Total Expenditures(Rs.Million)", freq = "Annual", type = "predictor"), # Adjusted name based on summary
  "GovRev" = list(file = "fiscal_development.csv", series_name = "Total Revenues (Rs.Million)", freq = "Annual", type = "predictor"), # Adjusted name based on summary
  "GovBorrow" = list(file = "public_debt.csv", series_name = "Domestic Debt (Rs. billion)", freq = "Annual", type = "predictor"),
  "Oil_Brent" = list(file = "CMO_historical_data_monthly.csv", series_name = "Crude oil, Brent", freq = "Monthly", type = "predictor"), # Specific Handling
  "NonOilIndex" = list(file = "CMO_historical_data_indices.csv", series_name = "Non-energy", freq = "Monthly", type = "predictor"), # Specific Handling
  "Imports" = list(file = "trade_and_payments.csv", series_name = "Imports ($ Million)", freq = "Monthly", type = "predictor"), # Adjusted name based on summary
  "Exports" = list(file = "trade_and_payments.csv", series_name = "Exports ($ Million)", freq = "Monthly", type = "predictor"), # Adjusted name based on summary
  "Remittances" = list(file = "seasonal_worker_remittance.csv", series_name = "Workers Remittances", freq = "Monthly", type = "predictor"), # Adjusted name based on summary
  "FDI_Total" = list(file = "foreign_invest_sectors.csv", series_name = "1 Net Foreign Direct Investment in Pakistan", freq = "Monthly", type = "predictor"), # Adjusted name based on summary
  "TP_Inflation_US" = list(file = "trade_partner_inflations.csv", series_name = "United States", freq = "Annual", type = "predictor"), # Specific Handling
  "TP_Inflation_CN" = list(file = "trade_partner_inflations.csv", series_name = "China, People's Republic of", freq = "Annual", type = "predictor"), # Specific Handling
  "TP_Inflation_UK" = list(file = "trade_partner_inflations.csv", series_name = "United Kingdom", freq = "Annual", type = "predictor"), # Specific Handling
  "GDP_Q" = list(file = "quaterly_gdp_2015.csv", series_name = "A. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16))", freq = "Quarterly", type = "predictor"), # Adjusted name based on summary
  "LSM_QIM" = list(file = "LSM_QIM_2015.csv", series_name = ". 1. Quantum Index of Large-scale Manufacturing (Base Period 2015-16) - Overall", freq = "Monthly", type = "predictor"), # Adjusted name based on summary
  "ElecGen" = list(file = "energy.csv", series_name = "Generation (GW/h)", freq = "Annual", type = "predictor"), # Wide format handling needed
  "Inflation_Exp" = list(file = "consumer_confidence_survey.csv", series_name = "Overall Consumer Confidence Index", freq = "Monthly", type = "predictor") # Using CCI as proxy
)
cat("Defined", length(variable_mapping), "variables for processing (Verified/Updated Version).\n")
# Check if expected Inflation Expectation / CCI proxy exists
if (! "Overall Consumer Confidence Index" %in% read.csv(file.path(data_folder, "consumer_confidence_survey.csv"), na=common_na_values)$Series.Display.Name) {
  warning("The series name 'Overall Consumer Confidence Index' was not found in consumer_confidence_survey.csv. Check mapping.")
}

# --- 2. Load and Combine Data (ADAPTED LOADING LOGIC) ----
all_data_long_list <- list()
for (var_short_name in names(variable_mapping)) {
  info <- variable_mapping[[var_short_name]]
  file_path <- file.path(data_folder, info$file)
  series_filter <- info$series_name
  cat("Processing:", var_short_name, "from", info$file, "...")
  if (!file.exists(file_path)) {
    warning(" File not found: ", file_path, ". Skipping.")
    cat(" Skipped (File not found).\n"); next
  }
  processed_df <- NULL
  tryCatch({
    if (info$file == "trade_partner_inflations.csv") {
      raw_df <- read_csv(file_path, na = common_na_values, show_col_types = FALSE)
      id_col_name <- names(raw_df)[1]
      filtered_row <- raw_df %>% filter(!!sym(id_col_name) == series_filter)
      if(nrow(filtered_row) == 1) {
        processed_df <- filtered_row %>% select(-all_of(id_col_name)) %>%
          pivot_longer(cols = everything(), names_to = "Date_Str", values_to = "Value") %>%
          mutate(
            Date = tryCatch(make_date(year = as.integer(Date_Str), month = 12, day = 31), error = function(e) NA),
            Value = suppressWarnings(as.numeric(Value)),
            Variable_Name = var_short_name, Source_Freq = info$freq
          ) %>% filter(!is.na(Date), !is.na(Value)) %>% select(Date, Variable_Name, Value, Source_Freq)
      } else { warning("Could not find unique row for '", series_filter, "' in ", info$file) }
    } else if (grepl("^CMO_historical_data", basename(info$file), ignore.case = TRUE)) {
      header_line <- readLines(file_path, n = 20); skip_rows <- NA
      date_pattern <- "^[[:space:]]*[0-9]{4}M[0-1][0-9]"
      for (i in 1:length(header_line)) {
        first_cell <- str_split(header_line[i], ",", simplify = TRUE)[1,1]
        if (grepl(date_pattern, first_cell)) { skip_rows <- i - 1; break } }
      if (is.na(skip_rows)) {
        if (grepl("indices", basename(info$file), ignore.case = TRUE)) { skip_rows <- 5
        } else if (grepl("monthly", basename(info$file), ignore.case = TRUE)) { skip_rows <- 4
        } else { skip_rows <- 6; warning("Using fallback skiprows=", skip_rows," for CMO file: ", info$file)} }
      raw_df <- read_csv(file_path, na = common_na_values, skip = skip_rows, guess_max = 5000, show_col_types = FALSE)
      date_col_name <- names(raw_df)[1]
      if (series_filter %in% names(raw_df)) {
        processed_df <- raw_df %>% select(Date_Str = all_of(date_col_name), Value = all_of(series_filter)) %>%
          mutate( Date = tryCatch(zoo::as.Date(zoo::as.yearmon(Date_Str)), error = function(e) NA),
                  Value = suppressWarnings(as.numeric(Value)), Variable_Name = var_short_name, Source_Freq = info$freq
          ) %>% filter(!is.na(Date), !is.na(Value)) %>% select(Date, Variable_Name, Value, Source_Freq)
      } else { warning("Could not find commodity column '", series_filter, "' in ", info$file) }
    } else if (info$file %in% c("fiscal_development.csv", "public_debt.csv", "energy.csv", "agriculture.csv", "economic_and_social_indicators.csv", "growth_and_investment.csv", "health_and_nutrition.csv", "manufacturing_and_mining.csv", "money_and_credit.csv", "population,_labor_force_and_employment.csv", "transport_and_communications.csv", "capital_markets_and_corporate_sector.csv", "education.csv")) {
      # --- Wide File Handling (Transposing Required) ---
      raw_df <- read_csv(file_path, na = common_na_values, show_col_types = FALSE, guess_max=5000)
      year_pattern <- "^(\\d{4}(?:[-\\/]\\d{2,4})?|\\d{4})$"; potential_id_cols <- names(raw_df)[!grepl(year_pattern, names(raw_df))]; year_cols <- names(raw_df)[grepl(year_pattern, names(raw_df))]
      if (length(potential_id_cols) == 0 || length(year_cols) == 0) { stop("Could not identify ID/Year columns in wide file: ", info$file) }
      id_col_for_filter <- potential_id_cols[1]
      filtered_rows <- raw_df %>% filter(!!sym(id_col_for_filter) == series_filter)
      if(nrow(filtered_rows) == 1) {
        transposed_df <- filtered_rows %>% select(all_of(year_cols)) %>% t() %>% as.data.frame(); names(transposed_df) <- "Value"; transposed_df$Date_Str <- rownames(transposed_df); rownames(transposed_df) <- NULL
        processed_df <- transposed_df %>% mutate(
          Start_Year = as.integer(str_extract(Date_Str, "^[0-9]{4}")),
          Date = make_date(year = Start_Year + ifelse(str_detect(Date_Str, "-"), 1, 0), month = ifelse(str_detect(Date_Str, "-"), 6, 12), day = ifelse(str_detect(Date_Str, "-"), 30, 31)),
          Value = suppressWarnings(as.numeric(Value)), Variable_Name = var_short_name, Source_Freq = info$freq
        ) %>% filter(!is.na(Date), !is.na(Value)) %>% select(Date, Variable_Name, Value, Source_Freq)
      } else { warning("Could not find unique row for series '", series_filter, "' in wide file ", info$file) }
    } else { # Standard Tall Format
      raw_df <- read_csv(file_path, na = common_na_values, guess_max = 10000, show_col_types = FALSE)
      required_cols <- c("Observation Date", "Series Display Name", "Observation Value")
      if (all(required_cols %in% names(raw_df))) {
        processed_df <- raw_df %>% select(Date_Str = `Observation Date`, Series_Name = `Series Display Name`, Value_Str = `Observation Value`) %>%
          filter(Series_Name == series_filter) %>% mutate(
            Date = case_when(
              grepl("^[A-Za-z]{3}-[0-9]{4}$", Date_Str) ~ ceiling_date(my(Date_Str),"month") - days(1),
              grepl("^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$", Date_Str) ~ parse_date_time(Date_Str, orders = "d-b-Y", quiet = TRUE),
              grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", Date_Str) ~ ymd(Date_Str),
              grepl("^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$", Date_Str) ~ parse_date_time(Date_Str, orders = "m/d/Y", quiet = TRUE),
              grepl("^[0-9]{4}$", Date_Str) ~ make_date(year=as.integer(Date_Str), month=12, day=31),
              TRUE ~ NA_Date_ ),
            Value = suppressWarnings(as.numeric(gsub(",", "", as.character(Value_Str)))),
            Variable_Name = var_short_name, Source_Freq = info$freq
          ) %>% filter(!is.na(Date), !is.na(Value)) %>% group_by(Date, Variable_Name, Source_Freq) %>%
          summarise(Value = mean(Value, na.rm = TRUE), .groups = 'drop') %>% select(Date, Variable_Name, Value, Source_Freq)
      } else { warning(" Standard columns not found in: ", info$file, ". Skipping."); cat(" Skipped.\n"); next } }
    if (!is.null(processed_df) && nrow(processed_df) > 0) {
      all_data_long_list[[var_short_name]] <- processed_df; cat(" OK (", nrow(processed_df), " rows).\n")
    } else { warning(" No valid data rows kept for: ", var_short_name); cat(" OK (0 rows).\n") }
  }, error = function(e) { warning("Error processing file ", info$file, ": ", e$message); cat(" Error.\n") })
}
if (length(all_data_long_list) == 0) { stop("No variables loaded. Stopping.") }
combined_long_raw <- bind_rows(all_data_long_list)
cat("Combined raw data. Dimensions:", dim(combined_long_raw), "\n")
print(table(combined_long_raw$Variable_Name))

# --- 3. Frequency Alignment (Convert All to Monthly) ----
cat("\n--- Aligning Frequencies to Monthly ---\n")
min_date_overall <- min(combined_long_raw$Date, na.rm = TRUE); max_date_overall <- max(combined_long_raw$Date, na.rm = TRUE)
max_date_overall <- max(max_date_overall, analysis_end_date, na.rm=TRUE); max_date_overall_month_end <- ceiling_date(max_date_overall, "month") %m-% days(1)
analysis_end_date_month_end <- ceiling_date(analysis_end_date, "month") %m-% days(1); max_seq_date <- max(max_date_overall_month_end, analysis_end_date_month_end, na.rm=TRUE)
if(is.infinite(max_seq_date) || is.na(max_seq_date)) {stop("Invalid max date.")}; if(is.infinite(min_date_overall) || is.na(min_date_overall)) {stop("Invalid min date.")}
all_months <- seq(floor_date(min_date_overall, "month"), max_seq_date, by = "month"); template_grid <- expand.grid( Date = all_months, Variable_Name = unique(combined_long_raw$Variable_Name) )
monthly_aligned <- combined_long_raw %>% mutate(Date_Month = floor_date(Date, "month")) %>%
  group_by(Variable_Name, Date_Month) %>% summarise( Value = case_when( first(Source_Freq) %in% c("Daily", "Weekly", "Monthly") ~ mean(Value, na.rm = TRUE),
                                                                        first(Source_Freq) %in% c("Quarterly", "Annual") ~ first(Value), TRUE ~ NA_real_ ), Source_Freq = first(Source_Freq), .groups = 'drop' ) %>% rename(Date = Date_Month) %>%
  right_join(template_grid, by = c("Date", "Variable_Name")) %>% group_by(Variable_Name) %>% fill(Source_Freq, .direction = "downup") %>% ungroup() %>% arrange(Variable_Name, Date)
cat("Data aligned to monthly grid. Dimensions:", dim(monthly_aligned), "\n")

# --- 4. Interpolation for Lower Frequency Data ----
cat("Interpolating Quarterly and Annual series...\n")
monthly_wide_temp <- monthly_aligned %>% select(Date, Variable_Name, Value) %>% pivot_wider(id_cols = Date, names_from = Variable_Name, values_from = Value)
freq_info <- monthly_aligned %>% distinct(Variable_Name, Source_Freq); cols_to_interpolate_info <- freq_info %>% filter(Source_Freq %in% c("Quarterly", "Annual"))
cols_to_interpolate <- intersect(cols_to_interpolate_info$Variable_Name, names(monthly_wide_temp))
if (length(cols_to_interpolate) > 0) {
  cat("Interpolating columns:", paste(cols_to_interpolate, collapse=", "), "\n")
  monthly_wide_interpolated <- monthly_wide_temp %>% arrange(Date) %>% mutate(across(all_of(cols_to_interpolate), ~ zoo::na.approx(.x, na.rm = FALSE, rule = 1))) %>%
    tidyr::fill(all_of(cols_to_interpolate), .direction = "downup")
} else { cat("No Quarterly/Annual columns found to interpolate.\n"); monthly_wide_interpolated <- monthly_wide_temp }
monthly_long_interpolated <- monthly_wide_interpolated %>% pivot_longer(cols = -Date, names_to = "Variable_Name", values_to = "Value")
cat("Interpolation complete.\n")

# --- 5. Transformations (Growth Rates, Lags) ----
cat("\n--- Applying Transformations (YoY Growth, Lags) ---\n")
monthly_wide_transformed <- monthly_long_interpolated %>% arrange(Variable_Name, Date) %>%
  pivot_wider(id_cols = Date, names_from = Variable_Name, values_from = Value) %>% arrange(Date)
vars_for_yoy <- c( "M2", "PSCredit", "PKR_USD_Avg", "REER", "GovExp", "GovRev", "GovBorrow", "FDI_Total",
                   "TP_Inflation_US", "TP_Inflation_CN", "TP_Inflation_UK", "Oil_Brent", "NonOilIndex",
                   "Imports", "Exports", "Remittances", "GDP_Q", "LSM_QIM", "ElecGen" )
target_already_yoy <- grepl("YoY", target_variable_series_name, ignore.case=TRUE)
if (!target_already_yoy) { vars_for_yoy <- c(vars_for_yoy, target_variable_short_name); target_col_final_name <- paste0(target_variable_short_name, "_YoY")
} else { target_col_final_name <- target_variable_short_name }
vars_for_yoy_present <- intersect(vars_for_yoy, names(monthly_wide_transformed))
if (length(vars_for_yoy_present) > 0) {
  cat("Calculating YoY growth for:", paste(vars_for_yoy_present, collapse=", "), "\n")
  monthly_wide_transformed <- monthly_wide_transformed %>%
    mutate(across(all_of(vars_for_yoy_present), ~ (.x / lag(.x, 12) - 1) * 100, .names = "{.col}_YoY"))
} else { cat("No specified variables for YoY growth found.\n") }
vars_for_diff <- c("PolicyRate", "KIBOR_3M"); vars_for_diff_present <- intersect(vars_for_diff, names(monthly_wide_transformed))
if (length(vars_for_diff_present) > 0) {
  cat("Calculating MoM difference for:", paste(vars_for_diff_present, collapse=", "), "\n")
  monthly_wide_transformed <- monthly_wide_transformed %>%
    mutate(across(all_of(vars_for_diff_present), ~ (.x - lag(.x, 1)), .names = "{.col}_Diff"))
} else { cat("No specified variables for MoM difference found.\n") }
predictors_to_lag <- c( grep("_YoY$", names(monthly_wide_transformed), value = TRUE), grep("_Diff$", names(monthly_wide_transformed), value = TRUE),
                        "Core_NFNE", "Core_Trimmed", "Inflation_Exp" )
predictors_to_lag <- setdiff(predictors_to_lag, target_col_final_name); predictors_to_lag_present <- intersect(predictors_to_lag, names(monthly_wide_transformed))
lag_periods <- c(1, 3, 6, 12)
if (length(predictors_to_lag_present) > 0) {
  cat("Creating lags", paste(lag_periods, collapse=", "), "for:", length(predictors_to_lag_present), "predictors...\n")
  for (lag_p in lag_periods) {
    monthly_wide_transformed <- monthly_wide_transformed %>%
      mutate(across(all_of(predictors_to_lag_present), ~ lag(.x, lag_p), .names = "{.col}_L{lag_p}")) }
} else { cat("No specified predictors for lagging found.\n") }
cat("Transformations applied.\n")

# --- 6. Final Selection and NA Handling (Using Full Predictor Set Initially) ----
cat("\n--- Final Data Selection and NA Handling (Full Predictor Set) ---\n")
target_col_final <- target_col_final_name
cat("Using target variable:", target_col_final, "\n")
# Define the pool of ALL potential predictor columns after transformation
potential_predictors <- c(
  grep("_YoY$", names(monthly_wide_transformed), value = TRUE),
  grep("_Diff$", names(monthly_wide_transformed), value = TRUE),
  grep("_L\\d+$", names(monthly_wide_transformed), value = TRUE),
  intersect(c("Core_NFNE", "Core_Trimmed", "Inflation_Exp"), names(monthly_wide_transformed))
)
potential_predictors <- unique(potential_predictors)
potential_predictors <- setdiff(potential_predictors, target_col_final) # Ensure target isn't predictor
potential_predictors_present <- intersect(potential_predictors, names(monthly_wide_transformed))

if (!target_col_final %in% names(monthly_wide_transformed)) { stop("Target column not found.") }
if (length(potential_predictors_present) == 0) { warning("No predictors found."); final_data_unscaled <- monthly_wide_transformed %>% select(Date, all_of(target_col_final))
} else { final_data_unscaled <- monthly_wide_transformed %>% select(Date, all_of(target_col_final), all_of(potential_predictors_present)) }

# Apply date filter and NA removal
final_data_unscaled <- final_data_unscaled %>%
  filter(Date >= analysis_start_date & Date <= analysis_end_date) %>%
  na.omit() # Critical step: removes rows with NA in *any* selected column

if(nrow(final_data_unscaled) == 0) { stop("No complete rows remaining after NA removal. Check data availability/lags.") }
cat("Dimensions of final data before scaling (Rows, Cols):", paste(dim(final_data_unscaled), collapse=" x "), "\n")
cat("Date range:", format(min(final_data_unscaled$Date)), "to", format(max(final_data_unscaled$Date)), "\n")


# --- 7. Standardization ----
cat("\n--- Standardizing Predictors ---\n")
predictor_cols_final <- setdiff(names(final_data_unscaled), c("Date", target_col_final))
if (length(predictor_cols_final) > 0) {
  scaling_params <- list(
    means = colMeans(final_data_unscaled[, predictor_cols_final, drop=FALSE], na.rm = TRUE),
    sds = apply(final_data_unscaled[, predictor_cols_final, drop=FALSE], 2, sd, na.rm = TRUE) )
  zero_sd_cols <- names(scaling_params$sds)[which(scaling_params$sds == 0 | is.na(scaling_params$sds))]
  if (length(zero_sd_cols) > 0) {
    warning("Predictors with zero/NA SD after NA omit: ", paste(zero_sd_cols, collapse=", "), ". Removing.")
    predictor_cols_final <- setdiff(predictor_cols_final, zero_sd_cols)
    final_data_unscaled <- final_data_unscaled %>% select(Date, all_of(target_col_final), all_of(predictor_cols_final))
    if(length(predictor_cols_final) > 0) {
      scaling_params <- list( means = colMeans(final_data_unscaled[, predictor_cols_final, drop=FALSE], na.rm = TRUE),
                              sds = apply(final_data_unscaled[, predictor_cols_final, drop=FALSE], 2, sd, na.rm = TRUE) )
      if(any(scaling_params$sds == 0 | is.na(scaling_params$sds))) { stop("Still problematic SDs.")}
    } else { scaling_params <- list(means=NULL, sds=NULL) } }
  if(length(predictor_cols_final) > 0) {
    final_data_scaled <- final_data_unscaled
    final_data_scaled[, predictor_cols_final] <- scale(final_data_unscaled[, predictor_cols_final, drop=FALSE], center = scaling_params$means, scale = scaling_params$sds)
    cat("Predictors standardized.\n")
  } else { final_data_scaled <- final_data_unscaled; cat("No predictors left to scale.\n") }
} else { final_data_scaled <- final_data_unscaled; scaling_params <- list(means=NULL, sds=NULL); cat("No predictors to standardize.\n") }

# --- 8. Save Processed Data ----
cat("\n--- Saving Processed Data (Full Predictor Set) ---\n")
scaled_rds_path <- file.path(output_folder, "final_data_scaled_monthly_v3_verified.rds")
unscaled_rds_path <- file.path(output_folder, "final_data_unscaled_monthly_v3_verified.rds")
params_rds_path <- file.path(output_folder, "scaling_parameters_v3_verified.rds") # Note: scaling params for full set
mapping_rds_path <- file.path(output_folder, "variable_mapping_used_v3_verified.rds")

saveRDS(final_data_scaled, scaled_rds_path)
cat("Scaled data saved to:", scaled_rds_path, "\n")
saveRDS(final_data_unscaled, unscaled_rds_path)
cat("Unscaled data saved to:", unscaled_rds_path, "\n")
saveRDS(scaling_params, params_rds_path)
cat("Scaling parameters saved to:", params_rds_path, "\n")
saveRDS(variable_mapping, mapping_rds_path)
cat("Variable mapping used saved to:", mapping_rds_path, "\n")

cat("\n--- Data Processing Pipeline Finished Successfully (v3 - Verified, Full Predictors) ---\n")
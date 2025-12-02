# Makefile for Pakistan Inflation Forecasting Project
# Provides convenient commands for development, testing, and deployment

.PHONY: all help install run run-eda run-merge run-prep run-arima run-reg run-eval test lint clean docker-build docker-run

# Default target
all: run

# Help target
help:
	@echo "Pakistan Inflation Forecasting Project"
	@echo ""
	@echo "Available commands:"
	@echo "  make install        - Install R dependencies"
	@echo "  make run            - Run the full analysis pipeline"
	@echo "  make run-eda        - Run only data loading and EDA"
	@echo "  make run-merge      - Run dataset merging"
	@echo "  make run-prep       - Run model preparation"
	@echo "  make run-arima      - Run ARIMA modeling"
	@echo "  make run-reg        - Run regularization modeling"
	@echo "  make run-eval       - Run model evaluation"
	@echo "  make test           - Run tests"
	@echo "  make lint           - Run lintr code checks"
	@echo "  make clean          - Remove generated files"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-run     - Run analysis in Docker"
	@echo ""

# Install R dependencies
install:
	@echo "Installing R dependencies..."
	@Rscript -e "install.packages(c('dplyr', 'ggplot2', 'forecast', 'glmnet', 'readr', 'lubridate', 'stringr', 'gridExtra', 'reshape2', 'knitr', 'tibble', 'tseries', 'zoo', 'tidyr', 'janitor', 'VIM', 'GGally', 'caret', 'corrplot', 'Matrix', 'purrr', 'moments', 'yaml', 'testthat', 'lintr'), repos='https://cloud.r-project.org/')"

# Create output directories
dirs:
	@mkdir -p Logs Output Processed_Data Plots Models Final_Results
	@mkdir -p Plots/eda Plots/model_prep Plots/arima Plots/regularization Plots/uncertainty Plots/evaluation
	@mkdir -p Processed_Data/uncertainty

# Run the full pipeline
run: dirs
	@echo "Running full analysis pipeline..."
	@Rscript 01_load_and_eda.R
	@Rscript 02_merge_datasets.R
	@Rscript 03_prepare_modeling_df.R
	@Rscript 04_arima_modeling.R
	@Rscript 05_regularization_modeling.R
	@Rscript 06_model_evaluation.R
	@echo "Pipeline completed! Results in Final_Results/"

# Run individual scripts
run-eda: dirs
	@echo "Running data loading and EDA..."
	@Rscript 01_load_and_eda.R

run-merge: dirs
	@echo "Running dataset merging..."
	@Rscript 02_merge_datasets.R

run-prep: dirs
	@echo "Running model preparation..."
	@Rscript 03_prepare_modeling_df.R

run-arima: dirs
	@echo "Running ARIMA modeling..."
	@Rscript 04_arima_modeling.R

run-reg: dirs
	@echo "Running regularization modeling..."
	@Rscript 05_regularization_modeling.R

run-eval: dirs
	@echo "Running model evaluation..."
	@Rscript 06_model_evaluation.R

# Run tests
test:
	@echo "Running tests..."
	@Rscript -e "testthat::test_dir('tests/testthat', reporter = 'summary')"

# Run lintr
lint:
	@echo "Running lintr..."
	@Rscript -e "lintr::lint_dir()"

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	@rm -rf Output Processed_Data Plots Models Final_Results Logs
	@rm -f *.rds *.RData *.Rout
	@rm -f cleaned_datasets.rds all_datasets.rds
	@rm -f 01_load_and_eda_output.txt
	@echo "Clean complete!"

# Docker commands
docker-build:
	@echo "Building Docker image..."
	@docker build -t pakistan-inflation-forecast:latest .

docker-run: docker-build
	@echo "Running analysis in Docker..."
	@docker-compose up forecast

docker-test: docker-build
	@echo "Running tests in Docker..."
	@docker-compose up test

docker-shell: docker-build
	@echo "Starting interactive shell..."
	@docker-compose run dev

# Check environment
check-env:
	@echo "Checking R environment..."
	@Rscript -e "sessionInfo()"
	@Rscript -e "cat('Required packages:\n'); sapply(c('dplyr', 'ggplot2', 'forecast', 'glmnet'), function(p) cat(sprintf('  %s: %s\n', p, ifelse(require(p, quietly=TRUE, character.only=TRUE), 'OK', 'MISSING'))))"

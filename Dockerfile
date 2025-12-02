FROM rocker/r-ver:4.3.2

LABEL maintainer="M. Abdullah Ali <abdullah.ali@example.com>"
LABEL description="Pakistan Inflation Forecasting Project"
LABEL version="1.0.0"

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libgit2-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c( \
    'dplyr', \
    'ggplot2', \
    'forecast', \
    'glmnet', \
    'readr', \
    'lubridate', \
    'stringr', \
    'gridExtra', \
    'reshape2', \
    'knitr', \
    'tibble', \
    'tseries', \
    'zoo', \
    'tidyr', \
    'janitor', \
    'VIM', \
    'GGally', \
    'caret', \
    'corrplot', \
    'Matrix', \
    'purrr', \
    'moments', \
    'yaml', \
    'testthat', \
    'lintr' \
    ), repos='https://cloud.r-project.org/')"

# Copy project files
COPY . /app

# Create output directories
RUN mkdir -p Logs Output Processed_Data Plots Models Final_Results

# Set environment variables
ENV R_LIBS_USER=/usr/local/lib/R/site-library

# Default command runs the full pipeline
CMD ["bash", "-c", "\
    Rscript 01_load_and_eda.R && \
    Rscript 02_merge_datasets.R && \
    Rscript 03_prepare_modeling_df.R && \
    Rscript 04_arima_modeling.R && \
    Rscript 05_regularization_modeling.R && \
    Rscript 06_model_evaluation.R \
"]

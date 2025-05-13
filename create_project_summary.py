#!/usr/bin/env python3
"""
Script to convert R files and README.md into a single .txt file with Markdown formatting.
This makes it easy to share the project with AI systems.

Usage:
    python create_project_summary.py

Output:
    pakistan_inflation_forecast_project.txt - A text file containing the project code and documentation
"""

import os
import glob

def read_file(file_path):
    """Read a file and return its contents as a string."""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            return file.read()
    except UnicodeDecodeError:
        # Try with a different encoding if UTF-8 fails
        with open(file_path, 'r', encoding='latin-1') as file:
            return file.read()
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return f"Error reading {file_path}: {e}"

def create_project_summary():
    """Create a project summary by combining README.md and R files."""
    # Output file
    output_file = "pakistan_inflation_forecast_project.txt"
    
    # Get list of R files in order
    r_files = [
        "01_load_and_eda.R",
        "02_merge_datasets.R",
        "03_prepare_modeling_df.R",
        "04_arima_modeling.R",
        "05_regularization_modeling.R",
        "06_model_evaluation.R"
    ]
    
    # Check if all files exist
    for file in r_files:
        if not os.path.exists(file):
            print(f"Warning: {file} not found")
    
    # Start with README.md
    readme_path = "README.md"
    if not os.path.exists(readme_path):
        print(f"Warning: {readme_path} not found")
        readme_content = "# Pakistan Inflation Forecasting Project\n\nREADME.md file not found.\n\n"
    else:
        readme_content = read_file(readme_path)
    
    # Create the output file
    with open(output_file, 'w', encoding='utf-8') as out_file:
        # Write README content
        out_file.write(readme_content)
        out_file.write("\n\n")
        
        # Add a section for code files
        out_file.write("# Project Code Files\n\n")
        
        # Process each R file
        for r_file in r_files:
            if os.path.exists(r_file):
                # Add a section header for the file
                out_file.write(f"## {r_file}\n\n")
                
                # Add the file content as a code block
                out_file.write("```r\n")
                out_file.write(read_file(r_file))
                out_file.write("\n```\n\n")
                
                print(f"Added {r_file} to summary")
            else:
                out_file.write(f"## {r_file}\n\n")
                out_file.write(f"File {r_file} not found.\n\n")
    
    print(f"\nProject summary created: {output_file}")
    print(f"This file can be shared with AI systems for analysis.")

if __name__ == "__main__":
    create_project_summary()

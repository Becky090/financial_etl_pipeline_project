#!/bin/bash

# ------------------------------------------------------
# Script: financial_script.sh
# Purpose: Building an ETL pipeline
# ------------------------------------------------------

echo "Step 1: Creating the 'raw' directory (if it doesn't already exist)..."
mkdir -p raw
echo "Directory 'raw' is ready."

echo "Step 2: Changing into the 'raw' directory..."
cd raw || { echo "Failed to enter 'raw' directory. Exiting."; exit 1; }
echo "Now in directory: $(pwd)"

echo "Step 3: Downloading the CSV file from the provided URL..."
curl -L -o financial_file.csv "$csv_url"

echo "Step 4: Confirming the file was downloaded successfully and not empty..."
if [ -s "financial_file.csv" ]; then
    echo "Success: 'financial_file.csv' has been saved in the 'raw' folder."
    ls -lh financial_file.csv
else
    echo "Error: File download failed or file is empty. 'financial_file.csv' not found."
    exit 1
fi


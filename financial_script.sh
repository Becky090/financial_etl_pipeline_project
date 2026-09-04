#!/bin/bash

# ------------------------------------------------------
# Script: financial_script.sh
# Purpose: Building an ETL pipeline
# ------------------------------------------------------

#------------- EXTRACT -------------------------
echo "Step 1: Creating the 'raw' directory (if it doesn't already exist)..."
mkdir -p raw
echo "Directory 'raw' is ready."

echo "Step 2: Downloading the CSV file from the provided URL..."
curl -L -o raw/financial_file.csv "$csv_url"

echo "Step 3: Confirming the file was downloaded successfully and not empty..."
if [ -s "raw/financial_file.csv" ]; then
    echo "Success: 'financial_file.csv' has been saved in the 'raw' folder."
    ls -lh raw/financial_file.csv
else
    echo "Error: File download failed or file is empty. 'financial_file.csv' not found."
    exit 1
fi


#------------------- TRANSFORM ----------------------------
echo "Step 4: Change Variable_code column name to variable_code"
sed -i '' '1s/Variable_code/variable_code/' raw/financial_file.csv

echo " Make directory Transformed to hold the transformed file"
mkdir -p Transformed
echo "Transformed folder created"
echo "Transform data( select year, Value, Units, variable_code columns)"
awk -F',' '
NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i=="Year") c1=i
        if ($i=="Value") c2=i
        if ($i=="Units") c3=i
        if ($i=="variable_code") c4=i
    }
}
{print $c1","$c2","$c3","$c4}
' raw/financial_file.csv > Transformed/2023_year_finance.csv

echo "Step 5: Confirming the file was saved in the 'Transformed' folder..."
if [ -s "Transformed/2023_year_finance.csv" ]; then
    echo "Success: '2023_year_finance.csv' has been saved in the 'Transformed' folder."
else
    echo "Error: File was not created or is empty in 'Transformed' folder."
    exit 1
fi
#------------- LOAD  -------------------------
echo "Step 6: Creating the 'Gold' directory (if it doesn't already exist)..."
mkdir -p Gold
echo "Directory 'Gold' is ready."

echo "Step 7: Loading the transformed file into the Gold directory..."
cp Transformed/2023_year_finance.csv Gold/2023_year_finance.csv

echo "Step 8: Confirming the file was saved in the 'Gold' folder..."
if [ -s "Gold/2023_year_finance.csv" ]; then
    echo "Success: '2023_year_finance.csv' has been saved in the 'Gold' folder."
else
    echo "Error: File was not created or is empty in 'Gold' folder."
    exit 1
fi

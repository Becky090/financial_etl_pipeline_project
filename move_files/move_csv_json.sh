#!/bin/bash

# ------------------------------------------------------
# Script: move_csv_json.sh
# Purpose: Move all CSV and JSON files from a source folder
#          into a destination folder called 'json_and_CSV'
# ------------------------------------------------------

source_folder="files_to_move"
destination_folder="json_and_CSV"

echo "Step 1: Creating the destination folder '$destination_folder' (if it doesn't already exist)..."
mkdir -p "$destination_folder"
echo "Destination folder is ready."

echo "Step 2: Searching '$source_folder' for .csv and .json files..."
count=$(find "$source_folder" -type f \( -name "*.csv" -o -name "*.json" \) | wc -l | tr -d ' ')

if [ "$count" -eq 0 ]; then
    echo "No CSV or JSON files found in '$source_folder'. Nothing to move."
    exit 0
fi

echo "Found $count matching file(s):"

echo "Step 3: Moving files to '$destination_folder'..."
find "$source_folder" -type f \( -name "*.csv" -o -name "*.json" \) -exec mv -v {} "$destination_folder"/ \;

echo "Step 4: Confirming files were moved successfully..."
moved_count=$(find "$destination_folder" -maxdepth 1 \( -name "*.csv" -o -name "*.json" \) | wc -l | tr -d ' ')

if [ "$moved_count" -gt 0 ]; then
    echo "Success: $moved_count CSV/JSON file(s) are now in '$destination_folder'."
    ls -lh "$destination_folder"
else
    echo "Error: No files found in '$destination_folder'. Move may have failed."
    exit 1
fi

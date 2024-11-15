#!/bin/bash

# Function to execute an install.sh in a specific directory
execute_script() {
    dir=$1
    echo "Processing directory: $dir"
    if [ -d "$dir" ]; then
        cd "$dir" || { echo "Failed to enter $dir"; exit 1; }
        if [ -f "install.sh" ]; then
            echo "Running install.sh in $dir"
            bash install.sh
            echo "Completed install.sh in $dir"
        else
            echo "install.sh not found in $dir"
        fi
        cd - > /dev/null || exit
    else
        echo "Directory $dir not found"
    fi
}

# List of directories to process
directories=(
    "preinstall"
    "security"
    "text-editor"
    "utility"
    "network"
    "network/wpa_supplicant"
)

# Display the menu
echo "Select an option:"
echo "1. Run all scripts in sequence"
echo "2. Run a specific script by directory name"
echo "3. Run scripts starting from a specific directory"

read -rp "Enter your choice: " choice

case $choice in
    1)
        # Run all scripts in sequence
        for dir in "${directories[@]}"; do
            execute_script "$dir"
        done
        ;;
    2)
        # Run a specific script
        read -rp "Enter the directory name: " dir_name
        if [[ " ${directories[*]} " == *" $dir_name "* ]]; then
            execute_script "$dir_name"
        else
            echo "Invalid directory name"
        fi
        ;;
    3)
        # Run scripts starting from a specific directory
        read -rp "Enter the starting directory name: " start_dir
        start=false
        for dir in "${directories[@]}"; do
            if [ "$dir" == "$start_dir" ]; then
                start=true
            fi
            if $start; then
                execute_script "$dir"
            fi
        done
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
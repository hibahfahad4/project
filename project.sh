#!/bin/bash
# This line specifies that the program will be executed by Bash.

#:File check + user input

# Filename to check
DATA_FILE="Data.txt"

# Check if the file exists
if [ -e "$DATA_FILE" ]; then
  # Check if the file is readable
  if [ -r "$DATA_FILE" ]; then
    echo "The file is readable."
  else
    echo "The file is not readable."
    exit 1
  fi
else
  echo "The file does not exist."
  exit 1
fi

# Welcome message
echo "Welcome to the Travel Recommendation Program :) "

# Ask user for trip goal
read -p "Enter your travel goal (Education, Entertainment): " goal
goal_lower=$(echo "$goal" | tr '[:upper:]' '[:lower:]') # Convert user input to lowercase for easy comparison

# Ask user for the number of adults
read -p "Enter number of adults going on the trip: " adults

# Validate if the number is correct
if ! [[ "$adults" =~ ^[0-9]+$ ]]; then
  echo "Please enter a valid number."
  exit 1
fi

# Ask for budget level
echo "Choose budget level:"
echo "1) Low"
echo "2) Medium"
echo "3) High"
read -p "Enter option (1-3): " budget_choice

# Convert user input to budget label
case $budget_choice in
  1) budget="Low" ;;
  2) budget="Medium" ;;
  3) budget="High" ;;
  *) echo "Invalid budget choice." ; exit 1 ;;
esac

echo ""
echo "Fetching suggestions for you..."
echo "-------------------------------—-"

print=0
    while read -r line; do
      # Check if the line matches the section (school or higher)
      if [[ "$line" == "$edu_section" ]]; then
        print=1
        continue
      fi
      # If we encounter another section, stop printing
      if [[ "$line" =~ "##" && "$line" != "$edu_section" ]]; then
        print=0
      fi

      # Filtering logic shared by both education and entertainment
      if [ $print -eq 1 ]; then
        if [ -z "$line" ]; then
          continue
        fi
        dest_budget=$(echo "$line" | sed 's/.*- *//')  # Extract the budget
        if [ "$dest_budget" == "$budget" ]; then
          dest_name=$(echo "$line" | sed 's/-.*//')  # Extract the destination name
          echo "- $dest_name"
        fi
      fi
    done < "$DATA_FILE"
    ;; 

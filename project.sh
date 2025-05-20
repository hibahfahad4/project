"entertainment")
# Determine if the number of adults is greater than 9
if [ "$adults" -gt 9 ]; then
group="Adults > 9"
else
group="Adults ≤ 9"
fi

# Print a message indicating what is being searched for
echo "Searching for $budget budget destinations for group: $group"

# Flag to indicate whether to print matching lines
print=0

# Read the data file line by line
while read -r line; do
# Start printing when the section for the group is found
echo "$line" | grep -q "## $group" && print=1 && continue


# Stop printing if a new section header is found
echo "$line" | grep -q "##" && print=0
    
# If we are in the correct group section and the line is not empty
if [ $print -eq 1 ] && [ -n "$line" ]; then
# Extract the budget value from

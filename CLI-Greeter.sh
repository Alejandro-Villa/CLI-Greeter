#!/bin/bash
# Author: Alejandro Villanueva (Github: Alejandro-Villa)
# Date: 16th July 2019
# Brief description: Prints a random quote from the array given. 
# The printed string will be centered and cropped out leaving 20 columns on each 
# side of the terminal.
#
# Version 3.0

help="Help placeholder."

if [[ $# != 1 ]]; then
	echo $help
else

	columns="$(tput cols)" # Get total of columns of the terminal window
	file=$(cat -E $1)
	delimiter="#"
	quotes_array=()
	quote_index=0
	for i in ${file[*]}; do  
	    if [[ "$i" = *"$delimiter"* ]]; then
	        quote_index="$(($quote_index+1))"
	    else
	        quotes_array[$quote_index]="${quotes_array[$quote_index]}"" ""$i"
	    fi
	done
	
	# Selects a random quote from the array using the system time as a seed
	RANDOM=$$$(date +%s)
	selected_quote=${quotes_array[$(($RANDOM % ${#quotes_array[@]}))]}
	
	# Splits the quoute into the actual text and the author
	IFS='$' read -ra printable_array <<< $selected_quote

	# Now the tricky part. Centering and cutting the edges out. For this I have used 
	# printf and a simple for loop with the chosen length of the quote on-screen
	
	line_size=$(($columns - 10)) # setting line size as columns
	
	# Printing the quote
	
	for ((i=0; i < ${#printable_array[@]}; i++)); do
	    if [[ ${#printable_array[$i]} -lt $line_size ]]; then
	        printf "%*s\n" $(( (${#printable_array[$i]}+ $columns) / 2  )) "${printable_array[$i]}"
	    else
	        line_number=$(( ${#printable_array[$i]} / $line_size  ))
	
	        if [[ $line_number*$line_size -ne ${#printable_array[$i]} ]]; then
				line_number=$(($line_number + 1))
	        fi

	        iterator=0
	        for (( j = 1; j <= $line_number; j++ )); do

	            tmp=${printable_array[$i]:$iterator:$(( $columns - 20 ))}

	            printf "%*s\n" $(( (${#tmp} + $columns) / 2  )) "$tmp"
	            iterator=$(( $iterator + $(( $columns - 20 )) ))
	        done
	fi
	
	done
fi

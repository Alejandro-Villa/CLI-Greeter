#!/bin/bash
# CLI-Greeter: This programm greets you with random quotes when run. 
#     Copyright (C) 2019  Alejandro Villanueva Prados
# 
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
#	  
#	  Contact information:
#		GitHub: Alejandro-Villa
#		E-mail: awewanwo@disroot.org
#
#
# Brief description: Prints a random quote from the array given. 
# The printed string will be centered and cropped out leaving 20 columns on each 
# side of the terminal.


help="Usage of this program:\n\t./CLI-Greeter <path-to-quote-file>\nOther usage, running\n\t./CLI-Greeter <-h | --help>\nwill show this message"

if [[ $# != 1 ]] || [[ "$2"=="-h" ]] || [[  "$2"=="--help" ]]; then
	echo -e $help
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

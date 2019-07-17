#!/bin/bash
# Author: Alejandro Villanueva (Github: Alejandro-Villa)
# Date: 16th July 2019
# Brief description: Prints a random quote from the array given. 
# The printed string will be centered and cropped out leaving 20 columns on each 
# side of the terminal.
#
# Version 1.0

columns=$(tput cols) # Get total of columns of the terminal window

#quotes_array=(
#"Las especies que sobreviven no son las más fuertes, ni las más rápidas, ni las más inteligentes; sino aquellas que se adaptan mejor al cambio.\a-- Charles Darwin"
#"Las grandes almas siempre se han encontrado con una oposición violenta de las mentes mediocres.\a-- Albert Einstein"
#"La religión es el opio del pueblo.\a-- Karl Marx"
#"Si la montaña no viene a ti, ve tú a la montaña.\a-- Mahoma"
#"Nuestra mayor gloria no está en no caer nunca, sino en levantarnos cada vez que caemos.\a-- Confucio"
#"No hay camino para la verdad, la verdad es el camino.\a-- Mahatma Gandhi"
#"Hijo mío, la felicidad está hecha de pequeñas cosas, un pequeño yate, una pequeña mansión, una pequeña fortuna.\a-- Groucho Marx"
#)

i=0
while read -r LINE 
do
    quotes_array[$i]=$LINE
    i=$i+1
done < $1

# Selects a random quote from the array using the system time as a seed
RANDOM=$$$(date +%s)
selected_quote=${quotes_array[$(($RANDOM % ${#quotes_array[@]}))]}

# Splits the quoute into the actual text and the author
IFS='\' read -ra printable_array <<< $selected_quote

# Now the tricky part. Centering and cutting the edges out. For this I have used 
# printf and a simple for loop with the chosen length of the quote on-screen
line_size=$(($columns - 10)) # setting line size as columns
printable_array[1]=${printable_array[1]:1:${#printable_array[1]}} # Removing the 'a' 

if [[ ${#printable_array[0]} -lt $line_size ]]; then
    printf "%*s\n" $(( (${#printable_array[0]} + $columns) / 2 )) "${printable_array[0]}"
    printf "%*s\n" $(( (${#printable_array[1]} + $columns) / 2 )) "${printable_array[1]}"
else
    line_number=$(( ${#printable_array[0]} / $line_size  ))

    if [[ $line_number*$line_size -ne ${#printable_array[0]} ]]; then
        line_number=$(($line_number + 1))
    fi

    iterator=0
    for (( i = 1; i <= $line_number; i++ )); do
        tmp=${printable_array[0]:$iterator:$(( $columns - 20 ))}
        printf "%*s\n" $(( (${#tmp} + $columns) / 2  )) "$tmp"
        iterator=$(( $iterator + $(( $columns - 20 )) ))
    done

    printf "%*s\n" $(( (${#printable_array[1]} + $columns) / 2  )) "${printable_array[1]}"
fi

#!/bin/bash
# Author: Alejandro Villanueva (Github: Alejandro-Villa)
# Date: 16th July 2019
# Brief description: Prints a random quote from the array given. 
# The printed string will be centered and cropped out leaving 20 columns on each 
# side of the terminal.
#
# Version 1.0

columns=$(tput cols) # Get total of columns of the terminal window

quotes_array=(
"Es preciso soñar, pero con la condición de creer en nuestros sueños. De examinar con atención la vida real, de confrontar nuestra observación con nuestros sueños, y de realizar escrupulosamente nuestra fantasía.\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"Que entre los marxistas no hay completa unanimidad, es cierto..., este hecho no demuestra la debilidad, sino precisamente la fuerza y la vitalidad de la socialdemocracia rusa.\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"No hay teoría revolucionaria sin práctica revolucionaria y viceversa.\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"La revolución no se hace, sino que se organiza.\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"Salvo el poder, todo es ilusión.\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"Si no eres parte de la solución, eres parte del problema, ¡actúa!\n--Vladimir \"Lenin\" Ilych Ulyanov" 
"El Estado es el arma de represión de una clase sobre otra.\n--Vladimir \"Lenin\" Ilych Ulyanov"
)

# Selects a random quote from the array using the system time as a seed
RANDOM=$$$(date +%s)
selected_quote=${quotes_array[$(($RANDOM % ${#quotes_array[@]}))]}

# Splits the quoute into the actual text and the author
IFS='\' read -ra printable_array <<< $selected_quote

# Now the tricky part. Centering and cutting the edges out. For this I have used 
# printf and a simple for loop with the chosen length of the quote on-screen
line_size=$(($columns - 10)) # setting line size as columns
printable_array[1]=${printable_array[1]:1:${#printable_array[1]}} # Removing the 'n' 

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

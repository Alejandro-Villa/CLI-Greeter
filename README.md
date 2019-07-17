# CLI-Greeter
A little bash script that greets you with your selection of quotes

## Detailed description and use.

To use this script you need to add it to your `.bashrc` (or equivalent), it'll run every time you start your terminal and choose a random quote and display it centered on the screen.

### Syntax

Run this in your terminal to use it with the default famous people quoutes
`./CLI-Greeter quotes/famous_people`

If you want to run it with a custom article, just give its route as an argument.

### Quotes format.

- Each quote goes in a separate line. (Quotes delimiter is the newline character `\n`)
- The author and the text are separated by `\a` (I know this character is the BELL one, I accept suggestions to a better delimiter)

## To-do list

* [**DONE**]Make it so you can change the quoutes without editing the code (preferably with a plain text file next to the script).
* Make it so it doesn't split up words.
* Make it compatible with Shell (not only bash)


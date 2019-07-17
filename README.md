# CLI-Greeter
A little bash script that greets you with your selection of quotes

## Detailed description and use.

If you want this script to greet you when you open your CLI, you need to add it to your `.bashrc` (or equivalent). It'll run every time you start your terminal and choose a random quote and display it centered on the screen.

### Syntax

Run this in your terminal to use it with the default famous people quoutes
`./CLI-Greeter quotes/famous_people`

If you want to run it with a custom file, just give its route as an argument.

### Quotes format.

- The script interprets `$` as a newline character (it ignores the file newlines). This way it supports multiline quotes and texts. The author-quote separation is also indicated by `$`
- The quote delimiter is `#`. It must follow each quote, separated from the last word by a space. Except the last quote, which doesn¡t require it.

## To-do list

* [**DONE**]Make it so you can change the quoutes without editing the code (preferably with a plain text file next to the script).
* Make it so it doesn't split up words.
* Make it compatible with Shell (not only bash)


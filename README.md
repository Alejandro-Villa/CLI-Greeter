# CLI-Greeter

A little Rust program that greets you with a selection of quotes.

## Installation Process
1. First of all, clone the git repo into your machine (`git clone git@github.com:Alejandro-Villa/CLI-Greeter.git`), if you don't have git you can download it from your distro repositories. More info about git [here](https://wiki.archlinux.org/index.php/Git).

2. Then, `cd` into the folder and run:

```bash
cargo build --release
cargo run quotes/famous-people --release
```

That should build and run the program with a pre-supplied example file.

## Detailed description and use.

If you want this script to greet you when you open your CLI, you need to add it to your `.bashrc` (or equivalent). It'll run every time you start your terminal and choose a random quote and display it centered on the screen.

Example:
```bash
# Other lines...

# CLI-Greeter
~/path-to-folder/target/release/cli-greeter ~/path-to-folder/quotes/famous-people
```

If you want to run it with a custom file, just give its route as an argument.

### Quotes format.

- All quotes must end with a newline character.
- The text of the quote _must_ be enclosed in double quotes (").
- The author is supplied right after the closing quote and up to the end of the line.

## Personalized quotes
I have included in `.gitignore` the file `quotes/personal`. You can put your personalized collection of quotes there, remember to follow the correct format specified above.

## To-do list

[x] Make it so you can change the quoutes without editing the code (preferably with a plain text file next to the script).
[x] Make it so it doesn't split up words.
[x] Make it compatible with Shell (not only bash).
[] Add meaningful errors and a integrated help.

## License and Contact Information.

This work is licensed with GPLv3.0. See the [license](https://github.com/Alejandro-Villa/CLI-Greeter/blob/master/LICENSE) for more information. 

You can contact me through GitHub or at `awewanwo@disroot.org`. I'm happy to answer any questions

## Notes: old version

There is an older version written in bash. It has suffered some minor changes in the quote format. You may find it in this repo history.

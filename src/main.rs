/// Script that takes a quote from a external file and shows it centered on the command line
/// interface.
use rand::seq::SliceRandom;
use std::env;
use std::fs;
use terminal_size::{terminal_size, Height, Width};

/// Struct that holds information about a quote and its author.
pub struct Quote {
    text: String,
    author: String,
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let quotes_file = &args[1];

    let contents = fs::read_to_string(quotes_file).expect("Error de apertura");

    let parsed = parse_contents(contents);
    let selected_opt = parsed.choose(&mut rand::thread_rng());

    if let Some(selected) = selected_opt {
        show_quote(selected);
    }
}

/// Function that parses the whole file contents, returns a `Vec<Quote>`.
///
/// # Examples.
///
/// Parses one `Quote`.
///
/// ```rust
///     let String text = "\"This is a quote\" this is the author";
///     let quotes = parse_contents(text);
/// ```

pub fn parse_contents(contents: String) -> Vec<Quote> {
    let lines = contents.lines();
    let lines_vec: Vec<&str> = lines.collect();

    let mut quotes_list: Vec<Quote> = Vec::new();

    for l in lines_vec {
        let tmp = Quote {
            text: get_quote(l.to_string()),
            author: get_author(l.to_string()),
        };

        quotes_list.push(tmp);
    }

    return quotes_list;
}

pub(crate) fn get_quote(contents: String) -> String {
    if contents.chars().next().unwrap() != '\"' {
        panic!("Quote must start with \"");
    }

    let mut copy = contents;
    assert_eq!(copy.remove(0), '\"');

    let mut cite = String::new();
    let mut enclosed = false;
    for c in copy.chars() {
        if c == '\"' {
            enclosed = true;
            break;
        }
        cite.push(c);
    }

    if !enclosed {
        panic!("Quote must end with \"");
    }

    return cite;
}

pub(crate) fn get_author(contents: String) -> String {
    if contents.chars().next().unwrap() != '\"' {
        panic!("Quote must start with \"");
    }

    let mut copy = contents;
    assert_eq!(copy.remove(0), '\"');

    let ind = copy.find('\"');

    if let Some(i) = ind {
        let author = copy.split_off(i + 1);
        return author;
    } else {
        panic!("Quote must end with \"");
    }
}

pub(crate) fn show_quote(cite: &Quote) {
    let size = terminal_size();
    if let Some((Width(w_raw), Height(_h))) = size {
        let w_total = usize::from(w_raw);

        if w_total > cite.text.len() + 20 {
            println!(
                "{cita:^width$}\n{author:^width$}",
                cita = cite.text,
                author = cite.author,
                width = w_total
            );
        } else {
            let parts = split_to_fit(&cite.text, w_total);
            for p in parts {
                println!("{cita:^width$}", cita = p, width = w_total);
            }
            println!("{author:^width$}", author = cite.author, width = w_total);
        }
    } else {
        println!("Width not found!!");
    }
}

pub(crate) fn split_to_fit(text: &String, space: usize) -> Vec<String> {
    let copy = String::from(text);

    let words: Vec<&str> = copy.split_whitespace().collect();
    let mut lines: Vec<String> = Vec::new();
    lines.push("".to_string());

    for w in words {
        if lines.last_mut().unwrap().len() + w.len() < space {
            lines.last_mut().unwrap().push_str(w);
            lines.last_mut().unwrap().push(' ');
        } else {
            lines.push("".to_string());
            lines.last_mut().unwrap().push_str(w);
            lines.last_mut().unwrap().push(' ');
        }
    }

    return lines;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_contents() {
        let text = "\"My quote\" my author".to_string();
        let quotes = parse_contents(text);

        assert_eq!(quotes[0].text, "My quote");
        assert_eq!(quotes[0].author, " my author");
    }

    #[test]
    fn test_empty_string() {
        let text: String = String::new();
        let quotes = parse_contents(text);

        assert!(quotes.is_empty());
    }

    #[test]
    fn test_get_quote() {
        let text = "\"a quote\"".to_string();

        assert_eq!(get_quote(text), "a quote");
    }

    #[test]
    #[should_panic(expected = "Quote must start with \"")]
    fn bad_format_quote() {
        let text = String::from("no quotes quote");

        let quote = get_quote(text);
        println!("Result: {}", quote);
    }

    #[test]
    #[should_panic(expected = "Quote must end with \"")]
    fn not_enclosed_quote_newline() {
        let text = String::from("\"Is this a quote\n");

        let quote = get_quote(text);
        println!("Result: {}", quote);
    }

    #[test]
    #[should_panic(expected = "Quote must end with \"")]
    fn not_enclosed_quote() {
        let text = String::from("\"Is this a quote");

        let quote = get_quote(text);
        println!("Result: {}", quote);
    }
}

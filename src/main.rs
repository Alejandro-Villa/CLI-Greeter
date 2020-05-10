use std::env;
use std::fs;
use terminal_size::{Width, Height, terminal_size};
use rand::seq::SliceRandom;

struct Quote {
    text: String,
    author: String,
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let quotes_file = &args[1];

    let contents = fs::read_to_string(quotes_file)
        .expect("Error de apertura");

    let parsed = parse_contents(contents);
    let selected_opt = parsed.choose(&mut rand::thread_rng());

    if let Some(selected) = selected_opt {
        show_quote(selected);
    }
}

fn parse_contents(contents: String) -> Vec<Quote> {
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

fn get_quote(contents: String) -> String {
    if contents.chars().next().unwrap() != '\"' {
        panic!("Quote must start with \"");
    }

    let mut copy = contents;
    assert_eq!(copy.remove(0), '\"');

    let mut cite = String::new();
    for c in copy.chars() {
        if c == '\"' {
            break;
        }
        cite.push(c);
    }

    return cite;
}

fn get_author(contents: String) -> String {
    if contents.chars().next().unwrap() != '\"' {
        panic!("Quote must start with \"");
    }

    let mut copy = contents;
    assert_eq!(copy.remove(0), '\"');

    let ind = copy.find('\"');

    if let Some(i) = ind {
        let author = copy.split_off(i+1);
        return author;
    } else {
        panic!("Quotes must be enclosed in \"\"");
    }
}

fn show_quote(cite: &Quote) {
    let size = terminal_size();
    if let Some((Width(w_raw), Height(_h))) = size {
        let w_total = usize::from(w_raw);

        if w_total > cite.text.len() + 20 {
            println!("{cita:^width$}\n{author:^width$}", 
                     cita=cite.text,
                     author=cite.author, 
                     width=w_total
                     );
        } else {
            let parts = split_to_fit(&cite.text, w_total);
            for p in parts {
                println!("{cita:^width$}",
                         cita=p,
                         width=w_total
                         );
            }
            println!("{author:^width$}", 
                     author=cite.author,
                     width=w_total
                     );
        }
    }
    else {
        println!("Width not found!!");
    }
}

fn split_to_fit(text: &String, space: usize) -> Vec<String> {
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

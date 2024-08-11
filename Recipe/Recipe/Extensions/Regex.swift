//
//  Regex.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 10/08/2024.
//

import Foundation
import RegexBuilder

let passwordRegex = Regex {
    /^/
    Lookahead {
        Regex {
            ZeroOrMore {
                /./
            }
            Repeat(2...) {
                One(.digit)
            }
        }
    }
    Lookahead {
        Regex {
            ZeroOrMore {
                /./
            }
            CharacterClass(
                ("a"..."z"),
                ("A"..."Z")
            )
        }
    }
    Lookahead {
        Regex {
            ZeroOrMore {
                /./
            }
            One(.anyOf("!@#$%^&*()_+-=[]{};':\"\\|,.<>/?"))
        }
    }
    Repeat(1...9) {
        CharacterClass(
            .anyOf("!@#$%^&*()_+-=[]{};':\"\\|,.<>/?"),
            ("A"..."Z"),
            ("a"..."z"),
            .digit
        )
    }
    /$/
}


let emailRegex = Regex {
        Capture {
            Regex {
                /^/
                OneOrMore {
                    CharacterClass(
                        .anyOf("._%+-"),
                        ("a"..."z"),
                        ("A"..."Z"),
                        ("0"..."9")
                    )
                }
                "@"
                OneOrMore {
                    CharacterClass(
                        .anyOf(".-"),
                        ("a"..."z"),
                        ("A"..."Z"),
                        ("0"..."9")
                    )
                }
                "."
                Repeat(2...) {
                    CharacterClass(
                        ("a"..."z"),
                        ("A"..."Z")
                    )
                }
                /$/
            }

    }
}

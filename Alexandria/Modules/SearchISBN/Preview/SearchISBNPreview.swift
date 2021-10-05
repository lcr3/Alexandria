//
//  SearchISBNPreview.swift
//  Alexandria
//
//  Created by lcr on 2021/10/05.
//  
//

import ISBNClient

struct MockSearchISBN {
    static var books: [ISBNBook] {
        [
            ISBNBook(title: "君主論"),
            ISBNBook(title: "ガリア戦記")
        ]
    }
}

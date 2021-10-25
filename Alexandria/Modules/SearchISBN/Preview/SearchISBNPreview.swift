//
//  SearchISBNPreview.swift
//  Alexandria
//
//  Created by lcr on 2021/10/05.
//  
//

import ISBNClient
import StorageClient

struct MockSearchISBN {
    static var books: [ISBNBook] {
        [
            ISBNBook(title: "君主論"),
            ISBNBook(title: "ガリア戦記")
        ]
    }
}

struct PreviewISBNClient: ISBNClientProtocol {
    func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
        completion(.success(
            [
                ISBNBook(
                    title: "コンビニ人間",
                    author: "村田沙耶香",
                    isbn: "9784167911300",
                    imageUrl: "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1300/9784167911300.jpg?_ex=64x64"
                ),
                ISBNBook(
                    title: "しろいろの街の、その骨の体温の",
                    author: "村田沙耶香",
                    isbn: "9784022647849",
                    imageUrl: "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7849/9784022647849.jpg?_ex=64x64"
                )
            ]
        ))
    }
}

struct PreviewStorageClient: StorageClientProtocol {
    var searchHistoryWords: [String]
    var libraryIds: [String]

    init() {
        self.libraryIds = ["1234"]
        self.searchHistoryWords = ["履歴"]
    }

    func saveLibraryIds(_ ids: [String]) {

    }

    func saveSearchHistory(word: String) {

    }

    func resetLibraryIds() {

    }

    func reset() {

    }
}

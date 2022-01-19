//  swiftlint:disable:this file_name
//  SearchISBNPreview.swift
//  Alexandria
//
//  Created by lcr on 2021/10/05.
//
//

import Foundation
import ISBNClient
import StorageClient

struct MockSearchISBN {
    var books: [ISBNBook] {
        [
            ISBNBook(title: "君主論"),
            ISBNBook(title: "ガリア戦記"),
        ]
    }
}

struct PreviewISBNClient: ISBNClientProtocol {
    func searchISBN(title _: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
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
                ),
            ]
        ))
    }
}

struct PreviewStorageClient: StorageClientProtocol {
    var libraries: [Data]
    var searchHistoryWords: [String]
    var libraryIds: [String]
    var isHaveStarted: Bool

    init() {
        libraryIds = ["1234"]
        libraries = []
        searchHistoryWords = ["履歴"]
        isHaveStarted = true
    }

    func saveLibraries(_: [Data]) {}
    func saveLibraryIds(_: [String]) {}

    func saveSearchHistory(word _: String) {}

    func saveIsHaveStarted() {}

    func resetLibraries() {}

    func deleteSearchHistory(index _: Int) {}

    func resetSearchHistory() {}

    func reset() {}
}

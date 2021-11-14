import APIKit
import Foundation

struct ISBNRequest: Request {
    typealias Response = [ISBNBook]

    var baseURL: URL {
        URL(string: "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404/")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        ""
    }

    var parameters: Any?

    public init(apiKey: String, title: String) {
        parameters = [
            "applicationId": apiKey,
            "title": title,
            "format": "json",
            "formatVersion": 2,
        ]
    }

    func response(from object: Any, urlResponse _: HTTPURLResponse) throws -> [ISBNBook] {
        print(object)
        guard let dictionary = object as? [String: Any],
              let results = dictionary["Items"] as? [[String: Any]]
        else {
            throw ResponseError.unexpectedObject(object)
        }
        var books: [ISBNBook] = []
        try results.forEach { result in
            print(result)
            books.append(try ISBNBook(object: result))
        }
        return books
    }
}

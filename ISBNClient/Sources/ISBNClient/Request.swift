import APIKit
import Foundation

struct ISBNRequest: Request {
    typealias Response = [ISBNBook]

    var baseURL: URL {
        return URL(string: "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404/")!
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return ""
    }

    var parameters: Any?

    public init(title: String) {
        parameters = [
            "applicationId": "1032630259901986279",
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

import APIKit
import Foundation

struct SearchNearbyLibrariesRequest: Request {
    typealias Response = [Library]
    var apiKey: String

    var baseURL: URL {
        URL(string: "https://api.calil.jp")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/library"
    }

    var parameters: Any?

    public init(apiKey: String, latitude: Double, longitude: Double) {
        self.apiKey = apiKey
        parameters = ["appkey": apiKey,
                      "geocode": "\(longitude),\(latitude)",
                      "format": "json",
                      "callback": ""]
    }

    func response(from object: Any, urlResponse _: HTTPURLResponse) throws -> [Library] {
        guard let dictionary = object as? [[String: Any]] else {
            throw ResponseError.unexpectedObject(object)
        }
        var books: [Library] = []
        try dictionary.forEach { result in
            print(result)
            books.append(try Library(object: result))
        }
        return books
    }
}

struct SearchForBooksInTheLibrariesRequest: Request {
    typealias Response = LibrarayResponse
    var apiKey: String
    var baseURL: URL {
        URL(string: "https://api.calil.jp")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/check"
    }

    var parameters: Any?

    public init(apiKey: String, isbn: String, libraryIds: [String]) {
        self.apiKey = apiKey
        parameters = ["appkey": apiKey,
                      "isbn": isbn,
                      "systemid": libraryIds.joined(separator: ","),
                      "format": "json",
                      "callback": "no"]
    }

    func response(from object: Any, urlResponse _: HTTPURLResponse) throws -> LibrarayResponse {
        let response = try LibrarayResponse(object: object)
        return response
    }
}

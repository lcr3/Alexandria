import APIKit
import Foundation

struct SearchNearbyLibrariesRequest: Request {
    typealias Response = [Library]

    var baseURL: URL {
        return URL(string: "https://api.calil.jp")!
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/library"
    }

    var parameters: Any?

    public init(latitude: Double, longitude: Double) {
        parameters = ["appkey": "ee9d6e54dd4601e91d0d962975ff704d",
                      "geocode": "\(longitude),\(latitude)",
                      "format": "json",
                      "callback": "",
        ]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Library] {
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

    var baseURL: URL {
        return URL(string: "https://api.calil.jp")!
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/check"
    }

    var parameters: Any?

    public init(isbn: String, libraryIds: [String]) {
        parameters = ["appkey": "ee9d6e54dd4601e91d0d962975ff704d",
                      "isbn": isbn,
                      "systemid": libraryIds.joined(separator: ","),
                      "format": "json",
                      "callback": "no"
        ]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> LibrarayResponse {
        let response = try LibrarayResponse(object: object)
        return response
    }
}

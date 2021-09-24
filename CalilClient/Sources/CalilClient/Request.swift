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

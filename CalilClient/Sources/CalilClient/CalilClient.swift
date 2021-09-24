import APIKit
import Foundation

public struct CalilClient {
    public init() {}
}

extension CalilClient {
    public func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        let request = SearchNearbyLibrariesRequest(latitude: latitude, longitude: longitude)
        Session.send(request) { result in
            switch result {
            case .success(let libraries):
                completion(.success(libraries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

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
        print(object)
        guard let dictionary = object as? [String: Any] else {
//              let results = dictionary["Items"] as? [[String: Any]] else {
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



public struct Library: Decodable {
    let pref: String
    let libid: String
    let systemid: String
    let systemName: String

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let pref = dictionary["pref"] as? String,
              let libid = dictionary["libid"] as? String,
              let systemid = dictionary["systemid"] as? String,
              let systemName = dictionary["systemname"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.pref = pref
        self.libid = libid
        self.systemid = systemid
        self.systemName = systemName
    }
}

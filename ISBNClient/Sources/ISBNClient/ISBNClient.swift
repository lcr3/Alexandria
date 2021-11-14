import APIKit
import Foundation

public protocol ISBNClientProtocol {
    func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void)
}

public struct ISBNClient {
    public let apiKey: String
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension ISBNClient: ISBNClientProtocol {
    public func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
        let request = ISBNRequest(apiKey: apiKey, title: title)
        Session.send(request) { result in
            switch result {
            case let .success(response):
                print(response.count)
                completion(.success(response))
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}

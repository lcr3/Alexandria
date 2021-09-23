import APIKit
import Foundation

public protocol ISBNClientProtocol {
    func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void)
}

public struct ISBNClient {
    public init() {}
}

extension ISBNClient: ISBNClientProtocol {
    public func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
        let request = ISBNRequest(title: title)
        Session.send(request) { result in
            switch result {
            case .success(let response):
                print(response.count)
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}

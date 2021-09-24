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

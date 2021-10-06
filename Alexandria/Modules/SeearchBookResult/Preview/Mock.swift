//
//  Mock.swift
//  Alexandria
//
//  Created by lcr on 2021/10/05.
//  
//

import CalilClient

public struct MockCalilClient {
}

extension MockCalilClient: CalilClientProtocol {
    public func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        completion(.success([Library(name: "図書館")]))
    }

    public func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        completion(.success([]))
    }
}

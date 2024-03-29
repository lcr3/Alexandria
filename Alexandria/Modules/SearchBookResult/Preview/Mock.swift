//  swiftlint:disable:this file_name
//  Mock.swift
//  Alexandria
//
//  Created by lcr on 2021/10/05.
//
//

import CalilClient
import CoreLocation
import LocationClient

public struct PreviewCalilClient {}

extension PreviewCalilClient: CalilClientProtocol {
    public func searchNearbyLibraries(latitude _: Double, longitude _: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        completion(.success([Library(name: "図書館")]))
    }

    public func searchForBooksInTheLibraries(isbn _: String, libraryIds _: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        completion(.success([]))
    }
}

public struct MockLocationClient {
    public var output: LocationClientOutput?
}

extension MockLocationClient: LocationClientProtocol {
    public func requestLocation() {
        output?.onLocationUpdated(.init(latitude: 135, longitude: 35))
    }

    public func stopUpdatingLocation() {}
}

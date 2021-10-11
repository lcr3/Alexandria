import Foundation

public struct Location {
    let latitude: Double
    let longitude: Double
}

public protocol StorageClientProtocol {
    var location: Location { get }
    var libraryIds: [String] { get }

    func saveLocation(latitude: Double, longitude: Double)
    func saveLibraryIds(_ ids: [String])
    func reset()
}

public struct StorageClient {
    private let userDafaults: UserDefaults
    private let latitudeKey = "latitude_key"
    private let longitudeKey = "longitude_key"
    private let libraryIdsKey = "library_ids_key"

    public init() {
        self.userDafaults = UserDefaults.standard
    }
}

extension StorageClient: StorageClientProtocol {
    public var location: Location {
        return Location(
            latitude: userDafaults.double(forKey: latitudeKey),
            longitude: userDafaults.double(forKey: longitudeKey)
        )
    }

    public var libraryIds: [String] {
        guard let ids = userDafaults.array(forKey: libraryIdsKey) as? [String] else {
            return []
        }
        return ids
    }

    public func saveLocation(latitude: Double, longitude: Double) {
        userDafaults.set(latitude, forKey: latitudeKey)
        userDafaults.set(longitude, forKey: longitudeKey)
    }

    public func saveLibraryIds(_ ids: [String]) {
        userDafaults.set(ids, forKey: libraryIdsKey)
    }

    public func reset() {
        guard let appDomain = Bundle.main.bundleIdentifier else {
            fatalError("domain is nil.")
        }
        userDafaults.removePersistentDomain(forName: appDomain)
    }
}

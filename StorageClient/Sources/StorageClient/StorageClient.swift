import Foundation

public struct Location {
    let latitude: Double
    let longitude: Double
}

public protocol StoregeClientProtocol {
    var location: Location { get }

    func saveLocation(latitude: Double, longitude: Double)
    func reset()
}

public struct StorageClient {
    private let userDafaults: UserDefaults
    private let latitudeKey = "latitude_key"
    private let longitudeKey = "longitude_key"

    public init() {
        self.userDafaults = UserDefaults.standard
    }
}

extension StorageClient: StoregeClientProtocol {
    public var location: Location {
        return Location(
            latitude: userDafaults.double(forKey: latitudeKey),
            longitude: userDafaults.double(forKey: longitudeKey)
        )
    }

    public func saveLocation(latitude: Double, longitude: Double) {
        userDafaults.set(latitude, forKey: latitudeKey)
        userDafaults.set(longitude, forKey: longitudeKey)
    }

    public func reset() {
        guard let appDomain = Bundle.main.bundleIdentifier else {
            fatalError("domain is nil.")
        }
        userDafaults.removePersistentDomain(forName: appDomain)
    }
}

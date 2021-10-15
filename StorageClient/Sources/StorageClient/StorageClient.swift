import Foundation

public protocol StorageClientProtocol {
    var libraryIds: [String] { get }

    func saveLibraryIds(_ ids: [String])
    func resetLibraryIds()
    func reset()
}

public struct StorageClient {
    private let userDafaults: UserDefaults
    private let libraryIdsKey = "library_ids_key"

    public init() {
        self.userDafaults = UserDefaults.standard
    }
}

extension StorageClient: StorageClientProtocol {
    public var libraryIds: [String] {
        guard let ids = userDafaults.array(forKey: libraryIdsKey) as? [String] else {
            return []
        }
        return ids
    }

    public func saveLibraryIds(_ ids: [String]) {
        userDafaults.set(ids, forKey: libraryIdsKey)
    }

    public func resetLibraryIds() {
        userDafaults.removeObject(forKey: libraryIdsKey)
    }

    public func reset() {
        guard let appDomain = Bundle.main.bundleIdentifier else {
            fatalError("domain is nil.")
        }
        userDafaults.removePersistentDomain(forName: appDomain)
    }
}

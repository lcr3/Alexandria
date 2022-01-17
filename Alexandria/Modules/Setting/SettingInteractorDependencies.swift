import ISBNClient
import StorageClient

protocol SettingInteractorDependenciesProtocol {
    var storegeClient: StorageClientProtocol { get }
}

struct SettingInteractorDependencies: SettingInteractorDependenciesProtocol {
    let storegeClient: StorageClientProtocol

    init(storegeClient: StorageClientProtocol = StorageClient()) {
        self.storegeClient = storegeClient
    }
}

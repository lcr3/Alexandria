import CalilClient
import StorageClient

protocol SearchBookResultInteractorDependenciesProtocol {
    var calilClient: CalilClientProtocol { get }
    var storageClient: StorageClientProtocol { get }
}

struct SearchBookResultInteractorDependencies: SearchBookResultInteractorDependenciesProtocol {
    let calilClient: CalilClientProtocol
    let storageClient: StorageClientProtocol
}

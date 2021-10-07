import CalilClient
import LocationClient
import StorageClient

protocol SelectAddressInteractorDependenciesProtocol {
    var calilClient: CalilClientProtocol { get }
    var locationClient: LocationClientProtocol { get set }
    var storageClient: StorageClient { get }
}

struct SelectAddressInteractorDependencies: SelectAddressInteractorDependenciesProtocol {
    let calilClient: CalilClientProtocol
    var locationClient: LocationClientProtocol
    let storageClient: StorageClient
}

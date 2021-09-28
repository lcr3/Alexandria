import CalilClient
import LocationClient
import StorageClient

protocol SelectAddressInteractorDependenciesProtocol {
    var calilClient: CalilClient { get }
    var locationClient: LocationClient { get }
    var storageClient: StorageClient { get }
}

struct SelectAddressInteractorDependencies: SelectAddressInteractorDependenciesProtocol {
    let calilClient: CalilClient
    let locationClient: LocationClient
    let storageClient: StorageClient
}

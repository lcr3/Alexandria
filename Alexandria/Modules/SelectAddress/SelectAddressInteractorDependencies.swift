import CalilClient
import LocationClient

protocol SelectAddressInteractorDependenciesProtocol {
    var calilClient: CalilClient { get }
    var locationClient: LocationClient { get }
}

struct SelectAddressInteractorDependencies: SelectAddressInteractorDependenciesProtocol {
    let calilClient: CalilClient
    var locationClient: LocationClient
}

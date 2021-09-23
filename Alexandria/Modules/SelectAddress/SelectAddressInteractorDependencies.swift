import LocationClient

protocol SelectAddressInteractorDependenciesProtocol {
    var client: LocationClient { get set }
}

struct SelectAddressInteractorDependencies: SelectAddressInteractorDependenciesProtocol {
    var client: LocationClient
}

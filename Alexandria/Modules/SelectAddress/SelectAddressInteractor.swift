import CoreLocation
import LocationClient

protocol SelectAddressInteractorOutput: AnyObject {
    func onUpdate(location: CLLocation)
    func onError(_: Error)
}

protocol SelectAddressInteractorProtocol {
    var output: SelectAddressInteractorOutput? { get set }
    func requestLocation()
}

final class SelectAddressInteractor {
    private let dependencies: SelectAddressInteractorDependenciesProtocol
    weak var output: SelectAddressInteractorOutput?

    init(dependencies: SelectAddressInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        self.dependencies.client.output = self
    }
}

extension SelectAddressInteractor: SelectAddressInteractorProtocol {
    func requestLocation() {
        dependencies.client.requestLocation()
    }
}

extension SelectAddressInteractor: LocationClientOutput {
    func onLocationUpdated(_ location: CLLocation) {
        output?.onUpdate(location: location)
    }

    func onError(_ error: Error) {
        output?.onError(error)
    }
}


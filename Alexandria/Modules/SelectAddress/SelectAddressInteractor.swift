import CoreLocation
import LocationClient
import CalilClient

protocol SelectAddressInteractorOutput: AnyObject {
    func onUpdate(location: CLLocation)
    func onError(_: Error)

    func successGet(libraries: [Library])
    func failureGetLibraries(_: Error)
}

protocol SelectAddressInteractorProtocol {
    var output: SelectAddressInteractorOutput? { get set }
    func requestLocation()
    func searchNearbyLibraries(latitude: Double, longitude: Double)
    func saveLocation(latitude: Double, longitude: Double)
    func saveLibraryIds(_ ids: [String])
}

final class SelectAddressInteractor {
    private let dependencies: SelectAddressInteractorDependenciesProtocol
    weak var output: SelectAddressInteractorOutput?

    init(dependencies: SelectAddressInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        self.dependencies.locationClient.output = self
    }
}

extension SelectAddressInteractor: SelectAddressInteractorProtocol {
    func requestLocation() {
        dependencies.locationClient.requestLocation()
    }

    func searchNearbyLibraries(latitude: Double, longitude: Double) {
        dependencies.calilClient.searchNearbyLibraries(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let libraries):
                self.output?.successGet(libraries: libraries)
            case .failure(let error):
                self.output?.failureGetLibraries(error)
            }
        }
    }

    func saveLocation(latitude: Double, longitude: Double) {
        dependencies.storageClient.saveLocation(latitude: latitude, longitude: longitude)
    }

    func saveLibraryIds(_ ids: [String]) {
        dependencies.storageClient.saveLibraryIds(ids)
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


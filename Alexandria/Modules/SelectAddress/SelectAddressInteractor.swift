import CoreLocation
import LocationClient
import CalilClient

protocol SelectAddressInteractorOutput: AnyObject {
    func onUpdate(location: CLLocation)
    func onError(_: Error)

    func successGet(libraries: [Library])
    func failureGetLibraries(_: SelectAddressError)
}

struct SelectAddressError: Error, Identifiable {
    var id = UUID()
    let title = "エラー"
    let description: String

    init(description: String) {
        self.description = description
    }
    static func emptyNearbyLibraries() -> Self {
        SelectAddressError(description: "近くに図書館が見つかりませんでした。")
    }
    static func error(_ description: String) -> Self {
        SelectAddressError(description: description)
    }
}

protocol SelectAddressInteractorProtocol {
    var output: SelectAddressInteractorOutput? { get set }
    func requestLocation()
    func stopUpdatingLocation()
    func searchNearbyLibraries(latitude: Double, longitude: Double)
    func saveLibraryIds(_ ids: [String])
    func isHaveStarted() -> Bool
    func saveIsHaveStarted()
}

final class SelectAddressInteractor {
    private var dependencies: SelectAddressInteractorDependenciesProtocol
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

    func stopUpdatingLocation() {
        dependencies.locationClient.stopUpdatingLocation()
    }

    func searchNearbyLibraries(latitude: Double, longitude: Double) {
        dependencies.calilClient.searchNearbyLibraries(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let libraries):
                if libraries.isEmpty {
                    self.output?.failureGetLibraries(.emptyNearbyLibraries())
                } else {
                    self.output?.successGet(libraries: libraries)
                }
            case .failure(let error):
                self.output?.failureGetLibraries(.error(error.localizedDescription))
            }
        }
    }

    func saveLibraryIds(_ ids: [String]) {
        dependencies.storageClient.saveLibraryIds(ids)
    }

    func isHaveStarted() -> Bool{
        return dependencies.storageClient.isHaveStarted
    }

    func saveIsHaveStarted() {
        dependencies.storageClient.saveIsHaveStarted()
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


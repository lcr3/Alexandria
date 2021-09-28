import CalilClient
import Combine
import CoreLocation
import MapKit

protocol SelectAddressPresenterProtocol {
    var region: MKCoordinateRegion { get set }
    var nearLibraries: [Library] { get set }
    func locationButtonTapped()
    func okButtonTapped()
}

final class SelectAddressPresenter: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var nearLibraries: [Library]

    private var dependencies: SelectAddressPresenterDependenciesProtocol
    private let interactor: SelectAddressInteractorProtocol
    
    init(dependencies: SelectAddressPresenterDependenciesProtocol, interactor: SelectAddressInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        self.region = .defaultRegion
        self.nearLibraries = []
    }
}

extension SelectAddressPresenter: SelectAddressPresenterProtocol {
    func locationButtonTapped() {
        interactor.requestLocation()
    }
}

extension SelectAddressPresenter: SelectAddressInteractorOutput {
    func okButtonTapped() {
    }

    func onUpdate(location: CLLocation) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(
                location.coordinate.latitude,
                location.coordinate.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )

        interactor.searchNearbyLibraries(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    func onError(_: Error) {
        region = .defaultRegion
    }

    func successGet(libraries: [Library]) {
        self.nearLibraries = libraries
    }

    func failureGetLibraries(_: Error) {

    }
}

private extension MKCoordinateRegion {
    // Tokyo
    static var defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2DMake(
            35.6895014,
            139.6917337
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
}

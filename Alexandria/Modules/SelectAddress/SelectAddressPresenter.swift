import Combine
import CoreLocation
import MapKit

protocol SelectAddressPresenterProtocol {
    var region: MKCoordinateRegion { get set }
    func locationButtonTapped()
}

final class SelectAddressPresenter: ObservableObject {
    @Published var region: MKCoordinateRegion

    private var dependencies: SelectAddressPresenterDependenciesProtocol
    private let interactor: SelectAddressInteractorProtocol
    
    init(dependencies: SelectAddressPresenterDependenciesProtocol, interactor: SelectAddressInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        self.region = .defaultRegion
    }
}

extension SelectAddressPresenter: SelectAddressPresenterProtocol {
    func locationButtonTapped() {
        interactor.requestLocation()
    }
}

extension SelectAddressPresenter: SelectAddressInteractorOutput {
    func onUpdate(location: CLLocation) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(
                location.coordinate.latitude,
                location.coordinate.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }

    func onError(_: Error) {
        self.region = .defaultRegion
    }
}

private extension MKCoordinateRegion {
    // Tokyo
    static var defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2DMake(
            36,
            140
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
}

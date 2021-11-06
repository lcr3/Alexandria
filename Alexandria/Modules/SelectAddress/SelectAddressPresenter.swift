import CalilClient
import Combine
import CoreLocation
import MapKit
import SwiftUI

protocol SelectAddressPresenterProtocol {
    var region: MKCoordinateRegion { get set }
    var nearLibraries: [Library] { get set }
    var error: SelectAddressError? { get set }
    func locationButtonTapped()
    func firstAlertOkButtonTapped()
    func okButtonTapped()
}

final class SelectAddressPresenter: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var nearLibraries: [Library]
    @Published var isPresented: Binding<Bool>
    @Published var userTrackingMode: MapUserTrackingMode
    @Published var libraryAnnotations: [AnnotationItem]
    @Published var isHaveStarted: Bool
    @Published var error: SelectAddressError?

    private let interactor: SelectAddressInteractorProtocol
    
    init(interactor: SelectAddressInteractorProtocol, isPresented: Binding<Bool>) {
        self.interactor = interactor
        self.region = .defaultRegion
        self.nearLibraries = []
        self.isPresented = isPresented
        self.userTrackingMode = .follow
        self.libraryAnnotations = []
        self.isHaveStarted = false
    }
}

extension SelectAddressPresenter: SelectAddressPresenterProtocol {
    func checkHaveStarted() {
        isHaveStarted = interactor.isHaveStarted()
    }

    func locationButtonTapped() {
        interactor.requestLocation()
    }

    func okButtonTapped() {
        if nearLibraries.isEmpty { return }
        let nearLibraryIds = nearLibraries.compactMap { $0.systemId }
        interactor.saveLibraryIds(nearLibraryIds)
        interactor.stopUpdatingLocation()
        self.isPresented.wrappedValue = false
    }

    func firstAlertOkButtonTapped() {
        interactor.saveIsHaveStarted()
    }
}

extension SelectAddressPresenter: SelectAddressInteractorOutput {
    func onUpdate(location: CLLocation) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(
                location.coordinate.latitude,
                location.coordinate.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
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
        var annotations: [AnnotationItem] = []
        libraries.forEach { library in
            annotations.append(
                AnnotationItem(
                    coordinate: .init(
                        latitude: library.latitude,
                        longitude: library.longitude
                    )
                )
            )
        }
        self.libraryAnnotations = annotations
    }

    func failureGetLibraries(_: SelectAddressError) {
        self.error = error
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


struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

import CalilClient
import LocationClient
import StorageClient
import SwiftUI

protocol SelectAddressWireFrameProtocol {
    static func makeSelectAddressView(isPresented: Binding<Bool>, calilClient: CalilClientProtocol, locationClient: LocationClientProtocol) -> AnyView
}

struct SelectAddressWireFrame: SelectAddressWireFrameProtocol {
    static func makeSelectAddressView(isPresented: Binding<Bool>, calilClient: CalilClientProtocol = CalilClient(), locationClient: LocationClientProtocol = LocationClient()) -> AnyView {
        let interactorDependencies = SelectAddressInteractorDependencies(
            calilClient: calilClient,
            locationClient: locationClient,
            storageClient: StorageClient()
        )
        let interactor = SelectAddressInteractor(dependencies: interactorDependencies)

        let presenter = SelectAddressPresenter(
            interactor: interactor,
            isPresented: isPresented
        )
        interactor.output = presenter
        let view = SelectAddressView(presenter: presenter)

        return AnyView(view)
    }
}

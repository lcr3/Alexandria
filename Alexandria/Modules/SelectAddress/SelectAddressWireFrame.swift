import CalilClient
import LocationClient
import StorageClient
import SwiftUI

protocol SelectAddressWireFrameProtocol {
    static func makeSelectAddressView(isPresented: Binding<Bool>) -> AnyView
}

struct SelectAddressWireFrame: SelectAddressWireFrameProtocol {
    static func makeSelectAddressView(isPresented: Binding<Bool>) -> AnyView {
        
        let interactorDependencies = SelectAddressInteractorDependencies(
            calilClient: CalilClient(),
            locationClient: LocationClient(),
            storageClient: StorageClient()
        )
        let interactor = SelectAddressInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = SelectAddressPresenterDepenencies()
        let presenter = SelectAddressPresenter(
            dependencies: presenterDependencies,
            interactor: interactor,
            isPresented: isPresented
        )
        interactor.output = presenter

        let viewDependencies = SelectAddressViewDependencies()
        let view = SelectAddressView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

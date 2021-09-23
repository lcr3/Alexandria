import SwiftUI
import LocationClient

protocol SelectAddressWireFrameProtocol {
   static func makeSelectAddressView() -> AnyView
}

struct SelectAddressWireFrame: SelectAddressWireFrameProtocol {
    static func makeSelectAddressView() -> AnyView {
        
        let interactorDependencies = SelectAddressInteractorDependencies(client: LocationClient())
        let interactor = SelectAddressInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = SelectAddressPresenterDepenencies()
        let presenter = SelectAddressPresenter(dependencies: presenterDependencies, interactor: interactor)
        interactor.output = presenter

        let viewDependencies = SelectAddressViewDependencies()
        let view = SelectAddressView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

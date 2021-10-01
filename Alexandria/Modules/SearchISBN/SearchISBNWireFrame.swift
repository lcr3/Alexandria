import SwiftUI

protocol SearchISBNWireFrameProtocol {
   static func makeSearchISBNView() -> AnyView
}

struct SearchISBNWireFrame: SearchISBNWireFrameProtocol {
    static func makeSearchISBNView() -> AnyView {
        
        let interactorDependencies = SearchISBNInteractorDependencies()
        let interactor = SearchISBNInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = SearchISBNPresenterDepenencies()
        let presenter = SearchISBNPresenter(dependencies: presenterDependencies, interactor: interactor)
        
        let viewDependencies = SearchISBNViewDependencies()
        let view = SearchISBNView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

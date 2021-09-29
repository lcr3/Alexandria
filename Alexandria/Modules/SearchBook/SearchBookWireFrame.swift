import SwiftUI

protocol SearchBookWireFrameProtocol {
   static func makeSearchBookView() -> AnyView
}

struct SearchBookWireFrame: SearchBookWireFrameProtocol {
    static func makeSearchBookView() -> AnyView {
        
        let interactorDependencies = SearchBookInteractorDependencies()
        let interactor = SearchBookInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = SearchBookPresenterDepenencies()
        let presenter = SearchBookPresenter(dependencies: presenterDependencies, interactor: interactor)
        
        let viewDependencies = SearchBookViewDependencies()
        let view = SearchBookView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

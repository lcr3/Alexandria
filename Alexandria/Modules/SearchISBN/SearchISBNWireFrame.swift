import ISBNClient
import StorageClient
import SwiftUI


protocol SearchISBNWireFrameProtocol {
    static func makeSearchISBNView(isbnClient: ISBNClientProtocol, storegeClient: StorageClientProtocol) -> AnyView
}

struct SearchISBNWireFrame: SearchISBNWireFrameProtocol {
    static func makeSearchISBNView(isbnClient: ISBNClientProtocol, storegeClient: StorageClientProtocol) -> AnyView {
        let interactorDependencies = SearchISBNInteractorDependencies(isbnClient: isbnClient, storegeClient: storegeClient)
        let interactor = SearchISBNInteractor(dependencies: interactorDependencies)

        let presenterDependencies = SearchISBNPresenterDepenencies()
        let presenter = SearchISBNPresenter(dependencies: presenterDependencies, interactor: interactor)
        interactor.output = presenter

        let viewDependencies = SearchISBNViewDependencies()
        let view = SearchISBNView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

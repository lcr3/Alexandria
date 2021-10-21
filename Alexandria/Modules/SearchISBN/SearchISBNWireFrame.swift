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

        let presenter = SearchISBNPresenter(interactor: interactor)
        interactor.output = presenter

        let view = SearchISBNView(presenter: presenter)
        
        return AnyView(view)
    }
}

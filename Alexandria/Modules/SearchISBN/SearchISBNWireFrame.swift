import ISBNClient
import SwiftUI

protocol SearchISBNWireFrameProtocol {
    static func makeSearchISBNView(books: [ISBNBook]) -> AnyView
}

struct SearchISBNWireFrame: SearchISBNWireFrameProtocol {
    static func makeSearchISBNView(books: [ISBNBook] = []) -> AnyView {
        
        let interactorDependencies = SearchISBNInteractorDependencies()
        let interactor = SearchISBNInteractor(dependencies: interactorDependencies)

        let presenterDependencies = SearchISBNPresenterDepenencies()
        let presenter = SearchISBNPresenter(dependencies: presenterDependencies, interactor: interactor)
        presenter.books = books
        interactor.output = presenter

        let viewDependencies = SearchISBNViewDependencies()
        let view = SearchISBNView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

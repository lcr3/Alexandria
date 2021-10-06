import CalilClient
import SwiftUI

protocol SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(isbn: String, libraryIds: [String], calilClient: CalilClientProtocol) -> AnyView
}

struct SearchBookResultWireFrame: SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(isbn: String, libraryIds: [String], calilClient: CalilClientProtocol = CalilClient()) -> AnyView {
        let interactorDependencies = SearchBookResultInteractorDependencies(
            calilClient: calilClient
        )
        let interactor = SearchBookResultInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = SearchBookResultPresenterDepenencies()
        let presenter = SearchBookResultPresenter(dependencies: presenterDependencies, interactor: interactor, isbn: isbn, libraryIds: libraryIds)
        interactor.output = presenter

        let viewDependencies = SearchBookResultViewDependencies()
        let view = SearchBookResultView(presenter: presenter, dependencies: viewDependencies)
        
        return AnyView(view)
    }
}

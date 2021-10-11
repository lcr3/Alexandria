import CalilClient
import StorageClient
import SwiftUI

protocol SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(isbn: String, libraryIds: [String], calilClient: CalilClientProtocol, storageClient: StorageClientProtocol) -> AnyView
}

struct SearchBookResultWireFrame: SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(isbn: String, libraryIds: [String], calilClient: CalilClientProtocol = CalilClient(), storageClient: StorageClientProtocol = StorageClient()) -> AnyView {
        let interactorDependencies = SearchBookResultInteractorDependencies(
            calilClient: calilClient,
            storageClient: storageClient
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

import CalilClient
import StorageClient
import SwiftUI

protocol SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(title: String, isbn: String, libraryIds: [String], calilClient: CalilClientProtocol, storageClient: StorageClientProtocol) -> AnyView
}

struct SearchBookResultWireFrame: SearchBookResultWireFrameProtocol {
    static func makeSearchBookResultView(title: String, isbn: String, libraryIds: [String], calilClient: CalilClientProtocol = CalilClient(), storageClient: StorageClientProtocol = StorageClient()) -> AnyView {
        let interactorDependencies = SearchBookResultInteractorDependencies(
            calilClient: calilClient,
            storageClient: storageClient
        )
        let interactor = SearchBookResultInteractor(dependencies: interactorDependencies)
        
        let presenter = SearchBookResultPresenter(interactor: interactor, title: title, isbn: isbn, libraryIds: libraryIds)
        interactor.output = presenter

        let view = SearchBookResultView(presenter: presenter)
        return AnyView(view)
    }
}

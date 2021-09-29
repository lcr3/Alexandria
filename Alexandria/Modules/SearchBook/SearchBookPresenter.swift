import Combine

protocol SearchBookPresenterProtocol {
    var exampleProperty: String { get set }
}

final class SearchBookPresenter: SearchBookPresenterProtocol, ObservableObject {
    @Published var exampleProperty: String = "Hello World!" {
        didSet {
            
        }
    }
    
    private var dependencies: SearchBookPresenterDependenciesProtocol
    private let interactor: SearchBookInteractorProtocol
    
    init(dependencies: SearchBookPresenterDependenciesProtocol, interactor: SearchBookInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

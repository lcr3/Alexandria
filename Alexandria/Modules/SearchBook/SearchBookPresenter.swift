import Combine

protocol SearchBookPresenterProtocol {
    var searchBookName: String { get set }
    func editSeachBookName(_ name: String)
}

final class SearchBookPresenter: SearchBookPresenterProtocol, ObservableObject {
    @Published var searchBookName: String
    
    private var dependencies: SearchBookPresenterDependenciesProtocol
    private let interactor: SearchBookInteractorProtocol
    
    init(dependencies: SearchBookPresenterDependenciesProtocol, interactor: SearchBookInteractorProtocol) {
        self.searchBookName = ""
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

extension SearchBookPresenter: SearchBookViewProtocol {
    func editSeachBookName(_ name: String) {
        searchBookName = name
    }
}

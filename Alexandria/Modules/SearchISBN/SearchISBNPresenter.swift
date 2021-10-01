import Combine

protocol SearchISBNPresenterProtocol {
    var searchISBNBookName: String { get set }
    func editSeachBookName(_ name: String)
    func searchButtonTapped()
}

final class SearchISBNPresenter: SearchISBNPresenterProtocol, ObservableObject {
    @Published var searchISBNBookName: String
    
    private var dependencies: SearchISBNPresenterDependenciesProtocol
    private let interactor: SearchISBNInteractorProtocol
    
    init(dependencies: SearchISBNPresenterDependenciesProtocol, interactor: SearchISBNInteractorProtocol) {
        self.searchISBNBookName = ""
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

extension SearchISBNPresenter: SearchISBNViewProtocol {
    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
    }

    func searchButtonTapped() {
        if searchISBNBookName.isEmpty {
            return
        }
        
    }
}

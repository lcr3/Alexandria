import Combine
import ISBNClient

protocol SearchISBNPresenterProtocol {
    var searchISBNBookName: String { get set }
    func editSeachBookName(_ name: String)
    func searchButtonTapped()
}

final class SearchISBNPresenter: SearchISBNPresenterProtocol, ObservableObject {
    @Published var searchISBNBookName: String = ""
    @Published var books: [ISBNBook] = []
    
    private var dependencies: SearchISBNPresenterDependenciesProtocol
    private let interactor: SearchISBNInteractorProtocol
    
    init(dependencies: SearchISBNPresenterDependenciesProtocol, interactor: SearchISBNInteractorProtocol) {
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
        interactor.searchBooks(name: searchISBNBookName)
    }
}

extension SearchISBNPresenter: SearchISBNInteractorOutput {
    func successSearchBooks(_ books: [ISBNBook]) {
        self.books = books
    }

    func failureSearchBooks(_: Error) {
    }
}

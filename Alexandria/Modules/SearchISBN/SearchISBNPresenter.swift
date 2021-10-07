import Combine
import ISBNClient

protocol SearchISBNPresenterProtocol {
    var searchISBNBookName: String { get set }
    func editSeachBookName(_ name: String)
    func searchButtonTapped()
    func deleteButtonTapped()
    func libraryIds() -> [String]
}

final class SearchISBNPresenter: SearchISBNPresenterProtocol, ObservableObject {
    @Published var searchISBNBookName: String = ""
    @Published var books: [ISBNBook] = []
    @Published var isSearching = false
    @Published var isShowSecond = false

    private var dependencies: SearchISBNPresenterDependenciesProtocol
    private let interactor: SearchISBNInteractorProtocol
    
    init(dependencies: SearchISBNPresenterDependenciesProtocol, interactor: SearchISBNInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        self.isShowSecond = !interactor.isSavedNearLibraries()
    }
}

extension SearchISBNPresenter: SearchISBNViewProtocol {
    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
        isSearching = !searchISBNBookName.isEmpty
    }

    func searchButtonTapped() {
        if searchISBNBookName.isEmpty {
            return
        }
        interactor.searchBooks(name: searchISBNBookName)
    }

    func deleteButtonTapped() {
        searchISBNBookName = ""
        isSearching = false
    }

    func libraryIds() -> [String] {
        interactor.libraryIds()
    }
}

extension SearchISBNPresenter: SearchISBNInteractorOutput {
    func successSearchBooks(_ books: [ISBNBook]) {
        self.books = books
    }

    func failureSearchBooks(_: Error) {
    }
}

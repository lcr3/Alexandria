import CalilClient
import Combine

protocol SearchBookResultPresenterProtocol {
    var isbn: String { get}
    var libraryIds: [String] { get }
    var libraryBooks: [LibraryBook] { get set }
}

final class SearchBookResultPresenter: SearchBookResultPresenterProtocol, ObservableObject {
    let isbn: String
    let libraryIds: [String]
    @Published var libraryBooks: [LibraryBook]
    @Published var isLoading: Bool
    
    private var dependencies: SearchBookResultPresenterDependenciesProtocol
    private let interactor: SearchBookResultInteractorProtocol
    
    init(dependencies: SearchBookResultPresenterDependenciesProtocol, interactor: SearchBookResultInteractorProtocol, isbn: String = "", libraryIds: [String] = []) {
        self.dependencies = dependencies
        self.interactor = interactor
        self.isbn = isbn
        self.libraryIds = libraryIds
        self.libraryBooks = []
        self.isLoading = false
    }

    func onApear() {
        isLoading = true
        interactor.searchForBooksInTheLibraries(isbn: isbn, libraryIds: libraryIds)
    }
}

extension SearchBookResultPresenter: SearchBookResultInteractorOutput {
    func successSearch(_ libraryBooks: [LibraryBook]) {
        isLoading = false
        self.libraryBooks = libraryBooks
    }

    func failureSearch(_: Error) {
        isLoading = false
    }
}

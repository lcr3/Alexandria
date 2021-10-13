import CalilClient
import Combine

protocol SearchBookResultPresenterProtocol {
    var isbn: String { get }
    var libraryIds: [String] { get }
    var libraryBooks: [LibraryBook] { get set }
    var selectedBook: LibraryBook? { get }
}

final class SearchBookResultPresenter: SearchBookResultPresenterProtocol, ObservableObject {
    let isbn: String
    let libraryIds: [String]
    let title: String

    @Published var libraryBooks: [LibraryBook]
    @Published var isLoading: Bool
    @Published var selectedBook: LibraryBook?
    
    private var dependencies: SearchBookResultPresenterDependenciesProtocol
    private let interactor: SearchBookResultInteractorProtocol
    
    init(dependencies: SearchBookResultPresenterDependenciesProtocol, interactor: SearchBookResultInteractorProtocol, title: String, isbn: String = "", libraryIds: [String] = []) {
        self.dependencies = dependencies
        self.interactor = interactor
        self.isbn = isbn
        self.libraryIds = libraryIds
        self.title = title
        libraryBooks = []
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

import CalilClient
import Combine
import Foundation

protocol SearchBookResultPresenterProtocol {
    var isbn: String { get }
    var libraryIds: [String] { get }
    var title: String { get }

    var libraryBooks: [LibraryBook] { get set }
    var isLoading: Bool { get set }
    var selectedBookUrl: URL? { get }
    var error: SearchBookResultInteractorError? { get set }

    func errorAlertOkButtonTapped()
}

final class SearchBookResultPresenter: ObservableObject {
    let isbn: String
    let libraryIds: [String]
    let title: String

    @Published var libraryBooks: [LibraryBook]
    @Published var isLoading: Bool
    @Published var selectedBookUrl: URL?
    @Published var error: SearchBookResultInteractorError?

    private let interactor: SearchBookResultInteractorProtocol

    init(interactor: SearchBookResultInteractorProtocol, title: String, isbn: String = "", libraryIds: [String] = []) {
        self.interactor = interactor
        self.isbn = isbn
        self.libraryIds = libraryIds
        self.title = title
        libraryBooks = []
        isLoading = true
        interactor.searchForBooksInTheLibraries(isbn: isbn, libraryIds: libraryIds)
    }
}

extension SearchBookResultPresenter: SearchBookResultPresenterProtocol {
    func errorAlertOkButtonTapped() {
        error = nil
    }
}

extension SearchBookResultPresenter: SearchBookResultInteractorOutput {
    func successSearch(_ libraryBooks: [LibraryBook]) {
        isLoading = false
        self.libraryBooks = libraryBooks
    }

    func failureSearch(_: SearchBookResultInteractorError) {
        isLoading = false
        error = error
    }
}

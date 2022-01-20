import CalilClient
import Combine
import Foundation

protocol SearchBookResultPresenterProtocol {
    var isbn: String { get }
    var title: String { get }
    var libraries: [Library] { get set }
    var libraryBooks: [LibraryBook] { get set }
    var isLoading: Bool { get set }
    var selectedBookUrl: URL? { get }
    var error: SearchBookResultInteractorError? { get set }

    func errorAlertOkButtonTapped()
}

final class SearchBookResultPresenter: ObservableObject {
    let isbn: String
    let title: String
    var libraries: [Library]

    @Published var libraryBooks: [LibraryBook]
    @Published var isLoading: Bool
    @Published var selectedBookUrl: URL?
    @Published var error: SearchBookResultInteractorError?

    private let interactor: SearchBookResultInteractorProtocol

    init(interactor: SearchBookResultInteractorProtocol, title: String, isbn: String = "", libraries: [Library]) {
        self.interactor = interactor
        self.isbn = isbn
        self.libraries = libraries
        self.title = title
        libraryBooks = []
        isLoading = true
        // TODO: Libraries nil check
        interactor.searchForBooksInTheLibraries(
            isbn: isbn,
            libraryIds: libraries.compactMap { library in
                library.systemId
            }
        )
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

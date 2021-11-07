import CalilClient

protocol SearchBookResultInteractorOutput: AnyObject {
    func successSearch(_ libraryBooks: [LibraryBook])
    func failureSearch(_: SearchBookResultInteractorError)
}

protocol SearchBookResultInteractorProtocol {
    var output: SearchBookResultInteractorOutput? { get set }
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String])
}

final class SearchBookResultInteractor {
    private let dependencies: SearchBookResultInteractorDependenciesProtocol
    var output: SearchBookResultInteractorOutput?

    init(dependencies: SearchBookResultInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension SearchBookResultInteractor: SearchBookResultInteractorProtocol {
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String]) {
        dependencies.calilClient.searchForBooksInTheLibraries(isbn: isbn, libraryIds: libraryIds) { result in
            switch result {
            case let .success(libraryBooks):
                print(libraryBooks)
                self.output?.successSearch(libraryBooks)
            case let .failure(error):
                print(error)
                self.output?.failureSearch(.network)
            }
        }
    }
}

enum SearchBookResultInteractorError: Error {
    case unknow
    case network
}

extension SearchBookResultInteractorError: Identifiable {
    var id: Self { self }
}

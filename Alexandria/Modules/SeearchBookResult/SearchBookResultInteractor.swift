import CalilClient

protocol SearchBookResultInteractorOutput: AnyObject {
    func successSearch(_ libraryBooks: [LibraryBook])
    func failureSearch(_: Error)
}

protocol SearchBookResultInteractorProtocol {
    var output: SearchBookResultInteractorOutput? { get set }
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String])
}

final class SearchBookResultInteractor: SearchBookResultInteractorProtocol {
    private let dependencies: SearchBookResultInteractorDependenciesProtocol
    var output: SearchBookResultInteractorOutput?

    init(dependencies: SearchBookResultInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }

    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String]) {
        dependencies.calilClient.searchForBooksInTheLibraries(isbn: isbn, libraryIds: libraryIds) { result in
            switch result {
            case .success(let libraryBooks):
                print(libraryBooks)
                self.output?.successSearch(libraryBooks)
            case .failure(let error):
                print(error)
                self.output?.failureSearch(error)
            }
        }
    }
}

import ISBNClient

protocol SearchISBNInteractorOutput: AnyObject {
    
    func successSearchBooks(_ books: [ISBNBook])
    func failureSearchBooks(_: Error)
}

protocol SearchISBNInteractorProtocol {
    func libraryIds() -> [String]
    func searchBooks(name: String)
    func isSavedNearLibraries() -> Bool
}

final class SearchISBNInteractor: SearchISBNInteractorProtocol {
    private let dependencies: SearchISBNInteractorDependenciesProtocol
    weak var output: SearchISBNInteractorOutput?

    init(dependencies: SearchISBNInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }

    func searchBooks(name: String) {
        dependencies.isbnClient.searchISBN(title: name) { result in
            switch result {
            case .success(let books):
                self.output?.successSearchBooks(books)
            case .failure(let error):
                self.output?.failureSearchBooks(error)
            }
        }
    }

    func isSavedNearLibraries() -> Bool {
        return !dependencies.storegeClient.libraryIds.isEmpty
    }

    func libraryIds() -> [String] {
        return dependencies.storegeClient.libraryIds
    }
}

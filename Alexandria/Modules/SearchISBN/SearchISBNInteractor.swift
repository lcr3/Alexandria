import ISBNClient

protocol SearchISBNInteractorOutput: AnyObject {
    func successSearchBooks(_ books: [ISBNBook])
    func failureSearchBooks(_: SearchISBNError)
    func featchSearchHistory(words: [String])
}

protocol SearchISBNInteractorProtocol {
    func libraryIds() -> [String]
    func featchSearchHistoryWords()
    func searchBooks(name: String)
    func deleteLocation()
    func isSavedNearLibraries() -> Bool
    func deleteHistory()

    var output: SearchISBNInteractorOutput? { get set }
}

final class SearchISBNInteractor: SearchISBNInteractorProtocol {
    private let dependencies: SearchISBNInteractorDependenciesProtocol
    weak var output: SearchISBNInteractorOutput?

    init(dependencies: SearchISBNInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }

    func searchBooks(name: String) {
        dependencies.storegeClient.saveSearchHistory(word: name)
        dependencies.isbnClient.searchISBN(title: name) { result in
            switch result {
            case let .success(books):
                if books.isEmpty {
                    self.output?.failureSearchBooks(.noMatch)
                    return
                }
                self.output?.successSearchBooks(books)
            case let .failure(error):
                print(error)
                self.output?.failureSearchBooks(.error(error.localizedDescription))
            }
        }
    }

    func deleteLocation() {
        dependencies.storegeClient.resetLibraryIds()
    }

    func isSavedNearLibraries() -> Bool {
        !dependencies.storegeClient.libraryIds.isEmpty
    }

    func libraryIds() -> [String] {
        dependencies.storegeClient.libraryIds
    }

    func featchSearchHistoryWords() {
        output?.featchSearchHistory(words: dependencies.storegeClient.searchHistoryWords)
    }

    func deleteHistory() {
        dependencies.storegeClient.resetSearchHistory()
    }
}

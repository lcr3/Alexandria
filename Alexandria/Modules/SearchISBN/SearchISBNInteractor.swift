import ISBNClient

protocol SearchISBNInteractorOutput: AnyObject {
    
    func successSearchBooks(_ books: [ISBNBook])
    func failureSearchBooks(_: SearchISBNError)
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
                if books.isEmpty {
                    self.output?.failureSearchBooks(.noMatch)
                    return
                }
                self.output?.successSearchBooks(books)
            case .failure(let error):
                print(error)
                self.output?.failureSearchBooks(.error("取得に失敗しました。"))
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

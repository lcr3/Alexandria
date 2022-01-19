import CalilClient
import Foundation
import ISBNClient

protocol SearchISBNInteractorOutput: AnyObject {
    func successSearchBooks(_ books: [ISBNBook])
    func failureSearchBooks(_: SearchISBNError)
    func featchSearchHistory(words: [String])
}

protocol SearchISBNInteractorProtocol {
    func libraries() -> [Library]
    func featchSearchHistoryWords()
    func searchBooks(name: String)
    func isSavedLibraries() -> Bool
    func deleteHistory(index: Int)
    func resetHistory()

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

//    func deleteLocation() {
//        dependencies.storegeClient.resetLibraryIds()
//    }

    func isSavedLibraries() -> Bool {
        !dependencies.storegeClient.libraries.isEmpty
    }

    func libraries() -> [Library] {
        let datas = dependencies.storegeClient.libraries
        var libraries: [Library] = []
        for data in datas {
            do {
                let library = try JSONDecoder().decode(Library.self, from: data)
                libraries.append(library)
            } catch {
                return []
            }
        }
        return libraries
    }

    func featchSearchHistoryWords() {
        output?.featchSearchHistory(words: dependencies.storegeClient.searchHistoryWords)
    }

    func deleteHistory(index: Int) {
        dependencies.storegeClient.deleteSearchHistory(index: index)
    }

    func resetHistory() {
        dependencies.storegeClient.resetSearchHistory()
    }
}

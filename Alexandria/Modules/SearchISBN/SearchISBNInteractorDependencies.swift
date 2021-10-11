import ISBNClient
import StorageClient

protocol SearchISBNInteractorDependenciesProtocol {
    var isbnClient: ISBNClient { get }
    var storegeClient: StorageClientProtocol { get }
}

struct SearchISBNInteractorDependencies: SearchISBNInteractorDependenciesProtocol {
    let isbnClient: ISBNClient
    let storegeClient: StorageClientProtocol

    init(isbnClient: ISBNClient = ISBNClient(), storegeClient: StorageClientProtocol = StorageClient()) {
        self.isbnClient = isbnClient
        self.storegeClient = storegeClient
    }
}

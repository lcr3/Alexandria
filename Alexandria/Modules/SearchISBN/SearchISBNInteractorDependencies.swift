import ISBNClient
import StorageClient

protocol SearchISBNInteractorDependenciesProtocol {
    var isbnClient: ISBNClient { get }
    var storegeClient: StoregeClientProtocol { get }
}

struct SearchISBNInteractorDependencies: SearchISBNInteractorDependenciesProtocol {
    let isbnClient: ISBNClient
    let storegeClient: StoregeClientProtocol

    init(isbnClient: ISBNClient = ISBNClient(), storegeClient: StoregeClientProtocol = StorageClient()) {
        self.isbnClient = isbnClient
        self.storegeClient = storegeClient
    }
}

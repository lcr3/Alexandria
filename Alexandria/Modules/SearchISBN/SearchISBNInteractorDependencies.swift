import ISBNClient
import StorageClient

protocol SearchISBNInteractorDependenciesProtocol {
    var isbnClient: ISBNClientProtocol { get }
    var storegeClient: StorageClientProtocol { get }
}

struct SearchISBNInteractorDependencies: SearchISBNInteractorDependenciesProtocol {
    let isbnClient: ISBNClientProtocol
    let storegeClient: StorageClientProtocol

    init(isbnClient: ISBNClientProtocol = ISBNClient(), storegeClient: StorageClientProtocol = StorageClient()) {
        self.isbnClient = isbnClient
        self.storegeClient = storegeClient
    }
}

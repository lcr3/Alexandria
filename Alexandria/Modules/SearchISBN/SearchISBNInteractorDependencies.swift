import ISBNClient

protocol SearchISBNInteractorDependenciesProtocol {
    var isbnClient: ISBNClient { get }
}

struct SearchISBNInteractorDependencies: SearchISBNInteractorDependenciesProtocol {
    let isbnClient: ISBNClient

    init(isbnClient: ISBNClient = ISBNClient()) {
        self.isbnClient = isbnClient
    }
}

protocol SearchISBNInteractorProtocol {
}

final class SearchISBNInteractor: SearchISBNInteractorProtocol {
    private let dependencies: SearchISBNInteractorDependenciesProtocol
    
    init(dependencies: SearchISBNInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

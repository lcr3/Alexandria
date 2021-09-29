protocol SearchBookInteractorProtocol {
    
}

final class SearchBookInteractor: SearchBookInteractorProtocol {
    private let dependencies: SearchBookInteractorDependenciesProtocol
    
    init(dependencies: SearchBookInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

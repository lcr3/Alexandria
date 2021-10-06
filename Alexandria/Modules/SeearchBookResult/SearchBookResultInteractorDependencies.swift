import CalilClient

protocol SearchBookResultInteractorDependenciesProtocol {
    var calilClient: CalilClientProtocol { get }
}

struct SearchBookResultInteractorDependencies: SearchBookResultInteractorDependenciesProtocol {
    let calilClient: CalilClientProtocol
}

import SwiftUI

protocol SearchBookViewProtocol {
    
}

struct SearchBookView: View, SearchBookViewProtocol {
    @ObservedObject private var presenter: SearchBookPresenter
    private let dependencies: SearchBookViewDependenciesProtocol
    
    var body: some View {
        Text(presenter.exampleProperty)
    }
    
    init(presenter: SearchBookPresenter,
         dependencies: SearchBookViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct SearchBookView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookWireFrame.makeSearchBookView()
    }
}

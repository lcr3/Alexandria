import SwiftUI

protocol SearchBookViewProtocol {
    
}

struct SearchBookView: View, SearchBookViewProtocol {
    @ObservedObject private var presenter: SearchBookPresenter
    private let dependencies: SearchBookViewDependenciesProtocol
    
    var body: some View {
        VStack {
            TextField("書籍名を入力", text: $presenter.searchBookName)
            Button("検索") {

            }
            .frame(width: .infinity)
            .padding(.top, 24)
        }.padding()
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

import SwiftUI

protocol SearchISBNViewProtocol {
    
}

struct SearchISBNView: View, SearchISBNViewProtocol {
    @ObservedObject private var presenter: SearchISBNPresenter
    private let dependencies: SearchISBNViewDependenciesProtocol
    
    var body: some View {
        VStack {
            HStack {
                TextField("書籍名を入力", text: $presenter.searchISBNBookName)
                Button("検索") {
                    presenter.searchButtonTapped()
                }
                .padding(.top, 24)
            }.frame(height: 44)
            Spacer()
            List(presenter.books) { book in
                Text(book.title)
            }
        }.padding()
    }
    
    init(presenter: SearchISBNPresenter,
         dependencies: SearchISBNViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct SearchISBNView_Previews: PreviewProvider {
    static var previews: some View {
        SearchISBNWireFrame.makeSearchISBNView()
    }
}

import SwiftUI

protocol SearchISBNViewProtocol {
    
}

struct SearchISBNView: View, SearchISBNViewProtocol {
    @ObservedObject private var presenter: SearchISBNPresenter
    private let dependencies: SearchISBNViewDependenciesProtocol
    
    var body: some View {
        ZStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.systemGray)
                            .padding(.leading, -12)
                        TextField("書籍名", text: $presenter.searchISBNBookName)
                        Button("検索") {
                            presenter.searchButtonTapped()
                        }
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            if presenter.isSearching {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.systemGray)
                                    .onTapGesture {
                                        presenter.deleteButtonTapped()
                                    }
                            }
                        }
                    )
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    init(presenter: SearchISBNPresenter,
         dependencies: SearchISBNViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct SearchISBNView_Previews: PreviewProvider {
    static var previews: some View {
        SearchISBNWireFrame.makeSearchISBNView(books: MockSearchISBN.books)
    }
}

import SwiftUI

protocol SearchISBNViewProtocol {
    
}

struct SearchISBNView: View, SearchISBNViewProtocol {
    @ObservedObject private var presenter: SearchISBNPresenter
    private let dependencies: SearchISBNViewDependenciesProtocol
    
    var body: some View {
        NavigationView {
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
                            if presenter.isSearching {
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.systemGray)
                                    .onTapGesture {
                                        presenter.deleteButtonTapped()
                                    }
                            }
                        }.padding(.trailing, 44)
                        )
                    }
                    Section {
                        ForEach(presenter.books) { book in
                            NavigationLink(destination: SearchBookResultWireFrame.makeSearchBookResultView(
                                isbn: book.isbn,
                                libraryIds: presenter.libraryIds()
                            )
                            ) {
                                HStack {
                                    Text(book.title)
                                    if !book.imageUrl.isEmpty {
                                        Spacer()
                                        AsyncImage(url: URL(string: book.imageUrl))
                                            .frame(maxWidth: .infinity, maxHeight: 44)
                                    }

                                }
                            }
                        }
                    }
                }
                .animation(.easeIn, value: 2)
                .listStyle(InsetGroupedListStyle())
                if presenter.isSearching {
                    ActivityIndicator()
                }
            }
            .alert("位置情報が設定されていません", isPresented: $presenter.isCurrentLocationNotSet) {
                VStack {
                    Button("設定する", role: .cancel) {
                        presenter.isCurrentLocationNotSetAlertOKButtonTapped()
                    }
                }
            }
            .alert("エラー", isPresented: $presenter.isShowError, presenting: presenter.error) { error in
                switch error {
                case .noMatch:
                    Text("該当する書籍はありませんでした")
                case .error(let message):
                    Text(message)
                }
                Button("OK", role: .cancel) {
                    presenter.errorAlertOkButtonTapped()
                }
            }
            .sheet(isPresented: $presenter.isShowModal) {
                // check
            } content: {
                SelectAddressWireFrame.makeSelectAddressView(
                    isPresented: $presenter.isShowModal
                )
            }
        }
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

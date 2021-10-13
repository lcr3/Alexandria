import SwiftUI

protocol SearchISBNViewProtocol {
    
}

struct SearchISBNView: View, SearchISBNViewProtocol {
    @ObservedObject private var presenter: SearchISBNPresenter
    private let dependencies: SearchISBNViewDependenciesProtocol
    
    var body: some View {
        NavigationView {
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
                        NavigationLink(destination:
                                        LazyView(
                                            SearchBookResultWireFrame.makeSearchBookResultView(
                                                title: book.title,
                                                isbn: book.isbn,
                                                libraryIds: presenter.libraryIds()
                                            )
                                        )
                        ) {
                            HStack(spacing: 16) {
                                if !book.imageUrl.isEmpty {
                                    AsyncImage(url: URL(string: book.imageUrl))
                                        .frame(maxWidth: 32, maxHeight: 32)
                                }
                                Text(book.title)
                            }.frame(height: 60)
                        }
                    }
                }
                .animation(.easeIn, value: 2)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle(Text("書籍を検索"))
            .alert("位置情報が設定されていません", isPresented: $presenter.isCurrentLocationNotSet) {
                VStack {
                    Button("設定する", role: .cancel) {
                        presenter.isCurrentLocationNotSetAlertOKButtonTapped()
                    }
                }
            }
            .alert(item: $presenter.error, content: { error in
                Alert(
                    title: Text(error.title),
                    message: Text(error.description),
                    dismissButton: .default(Text("OK"), action: {
                        presenter.errorAlertOkButtonTapped()
                    })
                )
            })
            .sheet(isPresented: $presenter.isShowModal) {
            } content: {
                LazyView(
                    SelectAddressWireFrame.makeSelectAddressView(
                        isPresented: $presenter.isShowModal
                    )
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
        SearchISBNWireFrame.makeSearchISBNView(
            isbnClient: MockISBNClient(),
            storegeClient: MockStorageClient()
        )
    }
}

import SwiftUI

protocol SearchISBNViewProtocol {
    
}

struct SearchISBNView: View, SearchISBNViewProtocol {
    @ObservedObject private var presenter: SearchISBNPresenter

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
                            hideKeyboard()
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
                if presenter.isSearching {
                    HStack {
                        Spacer()
                        ActivityIndicator(
                            isAnimating: $presenter.isSearching,
                            style: .large,
                            color: UIColor.white
                        )
                        Spacer()
                    }
                } else {
                    if presenter.books.isEmpty {
                        Section {
                            ForEach(presenter.searchHistoryWords, id: \.self) { word in
                                HStack {
                                    Text(word)
                                    Spacer()
                                    Image(systemName: "arrow.up.right.square.fill")
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    presenter.searchHistoryCellTapped(word: word)
                                }
                            }
                        } header: {
                            HStack {
                                Text("最近の検索")
                                Spacer()
                                Button {
                                    presenter.historyDeleteButtonTapped()
                                } label: {
                                    Image(systemName: "xmark.circle")
                                }
                            }
                        }
                    } else {
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
                }
            }
            .onAppear {
                presenter.onAppear()
            }
            .navigationTitle(Text("書籍を検索"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presenter.locationDeleteButtonTapped()
                    }) {
                        Image(systemName: "location.slash")
                    }.disabled(presenter.isCurrentLocationNotSet)
                }
            }
            .alert("位置情報が設定されていません", isPresented: $presenter.isCurrentLocationNotSet) {
                VStack {
                    Button("設定する", role: .cancel) {
                        presenter.isCurrentLocationNotSetAlertOKButtonTapped()
                    }
                }
            }
            .alert("設定されている位置情報を削除しますか？", isPresented: $presenter.isShowDeleteLocationAlert) {
                VStack {
                    Button("キャンセル", role: .cancel) {
                    }
                    Button("削除する", role: .destructive) {
                        presenter.locationDeleteAlertButtonTapped()
                    }
                }
            }
            .alert(item: $presenter.error, content: { error in
                Alert(
                    title: Text(error.title),
                    message: Text(error.description),
                    dismissButton: .default(Text("OK"))
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
        .navigationViewStyle(StackNavigationViewStyle())
    }

    init(presenter: SearchISBNPresenter) {
        self.presenter = presenter
    }
}

struct SearchISBNView_Previews: PreviewProvider {
    static var previews: some View {
        SearchISBNWireFrame.makeSearchISBNView(
            isbnClient: PreviewISBNClient(),
            storegeClient: PreviewStorageClient()
        )
    }
}

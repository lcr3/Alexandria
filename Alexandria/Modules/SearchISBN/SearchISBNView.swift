import CalilClient
import StorageClient
import SwiftUI

protocol SearchISBNViewProtocol {}

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
                        TextField(
                            L10n.searchBookName,
                            text: $presenter.searchISBNBookName
                        )
                        Button(L10n.searchButtonText) {
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
                            }.onDelete { index in
                                guard let index = index.first else { return }
                                presenter.deleteHistory(index: index)
                            }
                        } header: {
                            HStack {
                                Text(L10n.recentSearchText)
                                Spacer()
                                Button {
                                    presenter.resetHistoryButtonTapped()
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
                                            calilClient: CalilClient(apiKey: "ee9d6e54dd4601e91d0d962975ff704d")
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
            .navigationTitle(Text(L10n.seatchBookTitle))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presenter.locationDeleteButtonTapped()
                    } label: {
                        Image(systemName: "location.slash")
                    }
                }
            }
            .alert(
                L10n.locationNotSelectAlertTitle,
                isPresented: $presenter.isCurrentLocationNotSet
            ) {
                VStack {
                    Button(
                        L10n.setButtonTitle,
                        role: .cancel
                    ) {
                        presenter.isCurrentLocationNotSetAlertOKButtonTapped()
                    }
                }
            }
            .alert(
                L10n.locationDeleteAlertTitle,
                isPresented: $presenter.isShowDeleteLocationAlert
            ) {
                VStack {
                    Button(
                        L10n.cancelButtonTitle,
                        role: .cancel
                    ) {}
                    Button(
                        L10n.deleteButtonTitle,
                        role: .destructive
                    ) {
                        presenter.locationDeleteAlertButtonTapped()
                    }
                }
            }
            .alert(item: $presenter.error) {
                Alert(
                    title: Text($0.title),
                    message: Text($0.description),
                    dismissButton: .default(Text(L10n.okButtonTitle))
                )
            }
            .sheet(isPresented: $presenter.isShowModal) {
                LazyView(
                    SelectAddressWireFrame.makeSelectAddressView(
                        isPresented: $presenter.isShowModal,
                        calilClient: CalilClient(apiKey: "ee9d6e54dd4601e91d0d962975ff704d")
                    )
                )
            }
            .sheet(isPresented: $presenter.isShowSetting) {
                LazyView(
                    SettingWireFrame.makeSettingView(
                        storegeClient: StorageClient()
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

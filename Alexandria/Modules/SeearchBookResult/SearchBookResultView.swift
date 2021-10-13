import BetterSafariView
import CalilClient
import SwiftUI

protocol SearchBookResultViewProtocol {
}

struct SearchBookResultView: View, SearchBookResultViewProtocol {
    @ObservedObject private var presenter: SearchBookResultPresenter
    private let dependencies: SearchBookResultViewDependenciesProtocol
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(presenter.libraryBooks) { libraryBook in
                        if libraryBook.libraryStates.isEmpty {
                            Section(libraryBook.name) {
                                HStack {
                                    StateIcon(isAvailable: false)
                                    Text("蔵書なし")
                                }
                            }
                        } else {
                            Section(libraryBook.name) {
                                ForEach(libraryBook.libraryStates) { libraryState in
                                    HStack {
                                        StateIcon(isAvailable: libraryState.state.isAvailable)
                                        Text("\(libraryState.name): \(libraryState.state.rawValue)")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.system(.footnote).weight(.semibold))
                                            .foregroundColor(.gray)
                                            .foregroundColor(Color(UIColor.tertiaryLabel))
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if libraryBook.reserveUrl.isEmpty {
                                            return
                                        }
                                        presenter.selectedBook = libraryBook
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text(presenter.title))
            .navigationBarTitleDisplayMode(.inline)
            if presenter.isLoading {
                ZStack {
                    Color.gray.opacity(0.6)
                    ActivityIndicator(isAnimating: $presenter.isLoading,
                                      style: .large, color: UIColor.white)
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .safariView(item: $presenter.selectedBook) {
            // onDismiss
        } content: { book in
            SafariView(
                url: URL(string: book.reserveUrl)!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
        }
    }

    init(presenter: SearchBookResultPresenter,
         dependencies: SearchBookResultViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookResultWireFrame.makeSearchBookResultView(
            title: "サンプル",
            isbn: "test",
            libraryIds: [],
            calilClient: MockCalilClient()
        )
    }
}

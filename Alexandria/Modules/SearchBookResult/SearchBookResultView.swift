import BetterSafariView
import CalilClient
import SwiftUI

protocol SearchBookResultViewProtocol {}

struct SearchBookResultView: View, SearchBookResultViewProtocol {
    @ObservedObject private var presenter: SearchBookResultPresenter

    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(presenter.libraryBooks) { libraryBook in
                        if libraryBook.libraryStates.isEmpty {
                            Section(libraryBook.name) {
                                HStack {
                                    StateIcon(isAvailable: false)
                                    Text(L10n.searchBookSectionNotFoundTitle)
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
                                        guard let url = URL(string: libraryBook.reserveUrl) else {
                                            return
                                        }
                                        presenter.selectedBookUrl = url
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
        .alert(item: $presenter.error) { error in
            Alert(
                title: Text(L10n.errorAlertTitle),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text(L10n.okButtonTitle)) {
                    presenter.errorAlertOkButtonTapped()
                }
            )
        }
        .safariView(item: $presenter.selectedBookUrl) {
            // onDismiss
        } content: { url in
            SafariView(
                url: url,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
        }
    }

    init(presenter: SearchBookResultPresenter) {
        self.presenter = presenter
    }
}

//struct AboutMeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBookResultWireFrame.makeSearchBookResultView(
//            title: "サンプル",
//            isbn: "test",
//            calilClient: PreviewCalilClient()
//        )
//    }
//}

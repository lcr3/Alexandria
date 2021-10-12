import SwiftUI
import CalilClient

protocol SearchBookResultViewProtocol {
}

struct SearchBookResultView: View, SearchBookResultViewProtocol {
    @ObservedObject private var presenter: SearchBookResultPresenter
    private let dependencies: SearchBookResultViewDependenciesProtocol
    
    var body: some View {
        VStack {
            if presenter.isLoading {
                Text("検索中...📚")
                    .font(.body)
            } else {
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
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(Text(presenter.title))
        .onAppear {
            presenter.onApear()
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

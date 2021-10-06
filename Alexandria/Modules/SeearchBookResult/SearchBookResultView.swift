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
                                Text("蔵書なし")
                            }
                        } else {
                            Section(libraryBook.name) {
                                ForEach(libraryBook.libraryStates) { state in
                                    Text("\(state.name):\(state.state.rawValue)")
                                }
                            }
                        }
                    }
                }
            }
        }
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
            isbn: "test",
            libraryIds: [],
            calilClient: MockCalilClient()
        )
    }
}

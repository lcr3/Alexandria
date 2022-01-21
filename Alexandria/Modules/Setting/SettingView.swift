//
//  SettingView.swift
//  Alexandria
//
//  Created by lcr on 2022/01/17.
//

import SwiftUI

protocol SettingViewProtocol {}

struct SettingView: View, SettingViewProtocol {
    @ObservedObject private var presenter: SettingPresenter

    var body: some View {
        NavigationView {

            List {
                Section("登録されている図書館") {
                    ForEach(presenter.savedLibraries) { library in
                        Text(library.name)
                    }
                }
                Section() {
                    HStack {
                        Spacer()
                        Text("登録図書館をリセットする")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }.onTapGesture {
                    presenter.resetButtonTouched()
                }
            }.onAppear {
                presenter.getSaveLibraries()
            }
        }
    }

    init(presenter: SettingPresenter) {
        self.presenter = presenter
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingWireFrame.makeSettingView(
            storegeClient: PreviewStorageClient()
        )
    }
}

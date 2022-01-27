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
                if presenter.savedLibraries.isEmpty {
                    Section() {
                        Text(L10n.settingNoLibrariesSectionTitle)
                    }
                } else {
                    Section(L10n.settingLibrariesSectionTitle) {
                        ForEach(presenter.savedLibraries) { library in
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)

                                Text(library.name)
                            }
                        }
                    }
                }
                Section() {
                    HStack {
                        Spacer()
                        Text(L10n.locationDeleteButtonTitle)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }.onTapGesture {
                    presenter.resetButtonTouched()
                }
            }.onAppear {
                presenter.getSaveLibraries()
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
            .navigationTitle(L10n.settingViewTitle)
        }
    }

    init(presenter: SettingPresenter) {
        self.presenter = presenter
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingWireFrame.makeSettingView(
                storegeClient: PreviewStorageClient(isSaved: true)
            )
            SettingWireFrame.makeSettingView(
                storegeClient: PreviewStorageClient(isSaved: false)
            )
        }
    }
}

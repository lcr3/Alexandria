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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    init(presenter: SettingPresenter) {
        self.presenter = presenter
    }
}

// struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingWireFrame.makeSettingView(
//            storegeClient: MockStorageClient()
//        )
//    }
// }

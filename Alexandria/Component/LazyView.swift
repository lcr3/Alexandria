//
//  LazyView.swift
//  Alexandria
//
//  Created by lcr on 2021/10/13.
//
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: some View {
        build()
    }
}

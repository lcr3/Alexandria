//
//  ActivityIndicator.swift
//  Alexandria
//
//  Created by lcr on 2021/10/07.
//  
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: UIColor

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indigatorView = UIActivityIndicatorView(style: style)
        indigatorView.color = color
        return indigatorView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

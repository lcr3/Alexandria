//  swiftlint:disable:this file_name
//  Extensions.swift
//  Alexandria
//
//  Created by lcr on 2021/10/14.
//
//

import SwiftUI

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
#endif

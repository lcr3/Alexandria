//
//  StateIcon.swift
//  Alexandria
//
//  Created by lcr on 2021/10/12.
//  
//

import SwiftUI

struct StateIcon: View {
    let isAvailable: Bool

    var body: some View {
        Circle()
            .fill(isAvailable ? .green: .red)
            .frame(width: 5, height: 5)
    }
}

struct StateIcon_Previews: PreviewProvider {
    static var previews: some View {
        StateIcon(isAvailable: true)
    }
}


//
//  LibraryListView.swift
//  Alexandria
//
//  Created by lcr on 2021/09/24.
//
//

import CalilClient
import SwiftUI

struct LibraryListView: View {
    @Binding var items: [Library]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(items) { library in
                    VStack {
                        Text(library.name)
                            .bold()
                            .padding(.bottom, 16)
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.main)
                            Text(library.address)
                                .font(.caption2)
                        }
                    }
                    .frame(width: 300, height: 120)
                    .cornerRadius(24)
                }
            }
            .padding(.horizontal, 12)
        }
    }
}

struct LibraryListView_Previews: PreviewProvider {
    @State static var libs = [
        Library(
            name: "千代田区立神田まちかど図書館",
            address: "東京都千代田区神田司町2-16 神田さくら館内",
            pref: "東京都",
            libid: "105593",
            systemId: "Univ_Nihon_Den",
            systemName: "東京都千代田区",
            category: "UNIV"
        ),
        Library(
            name: "損害保険事業総合研究所図書館",
            address: "東京都千代田区神田駿河台1-8-13",
            pref: "東京都",
            libid: "105593",
            systemId: "Univ_Nihon_Den",
            systemName: "損保総研図書館",
            category: "UNIV"
        ),
    ]

    static var previews: some View {
        LibraryListView(items: $libs)
    }
}

//
//  AlexandriaApp.swift
//  Alexandria
//
//  Created by lcr on 2021/09/23.
//  
//

import ISBNClient
import StorageClient
import SwiftUI

@main
struct AlexandriaApp: App {
    var body: some Scene {
        WindowGroup {
            SearchISBNWireFrame.makeSearchISBNView(
                isbnClient: ISBNClient(),
                storegeClient: StorageClient()
            )
        }
    }
}

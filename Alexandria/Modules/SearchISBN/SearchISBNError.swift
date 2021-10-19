//
//  SearchISBNError.swift
//  Alexandria
//
//  Created by lcr on 2021/10/13.
//  
//

import Foundation

struct ErrorInfo: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var error: SearchISBNError

    init(type: SearchISBNError) {
        error = type
        title = error.title
        description = error.description
    }
}

enum SearchISBNError: Error, Equatable {
    case noMatch
    case error(String)

    var title: String {
        return "エラー"
    }

    var description: String {
        switch self {
        case .noMatch:
            return "該当の図書は見つかりませんでした"
        case .error(let message):
            return message
        }
    }
}

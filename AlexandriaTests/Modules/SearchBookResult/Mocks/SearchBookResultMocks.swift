//
//  SearchBookResultMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/22.
//
//

import CalilClient
import Foundation

@testable import Alexandria

final class MockSearchBookResultInteractor {
    init() {}
    var output: SearchBookResultInteractorOutput?
    var searchForBooksInTheLibrariesCallCount = 0
    var mockLibraryBooks: [LibraryBook] = []
    var mockError: SearchBookResultInteractorError?
}

extension MockSearchBookResultInteractor: SearchBookResultInteractorProtocol {
    func searchForBooksInTheLibraries(isbn _: String, libraryIds _: [String]) {
        searchForBooksInTheLibrariesCallCount += 1
        if let error = mockError {
            output?.failureSearch(error)
        } else {
            output?.successSearch(mockLibraryBooks)
        }
    }
}

final class MockSearchBookResultPresenter: SearchBookResultPresenterProtocol {
    var isbn: String
    var libraries: [Library]
    var title: String
    var libraryBooks: [LibraryBook]
    var isLoading: Bool
    var selectedBook: LibraryBook?
    var error: SearchBookResultInteractorError?
    var selectedBookUrl: URL?
    private let interactor: SearchBookResultInteractorProtocol

    init(interactor: SearchBookResultInteractorProtocol, title: String, isbn: String = "", libraries: [Library] = []) {
        self.interactor = interactor
        self.isbn = isbn
        self.libraries = libraries
        self.title = title
        libraryBooks = []
        isLoading = true
        interactor.searchForBooksInTheLibraries(
            isbn: isbn,
            libraryIds: libraries.compactMap { library in
                library.systemId
            }
        )
    }

    func errorAlertOkButtonTapped() {}
}

extension MockSearchBookResultPresenter: SearchBookResultInteractorOutput {
    func successSearch(_ libraryBooks: [LibraryBook]) {
        isLoading = false
        self.libraryBooks = libraryBooks
    }

    func failureSearch(_: SearchBookResultInteractorError) {
        isLoading = false
        // TODO: error
    }
}

class MockCalilClient: CalilClientProtocol {
    var searchNearbyLibrariesLibrarys: [Library] = []
    var searchNearbyLibrariesError: Error?

    var searchLibraryBooks: [LibraryBook] = []
    var searchLibraryBooksError: Error?

    func searchNearbyLibraries(latitude _: Double, longitude _: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        if let error = searchNearbyLibrariesError {
            completion(.failure(error))
        } else {
            completion(.success(searchNearbyLibrariesLibrarys))
        }
    }

    func searchForBooksInTheLibraries(isbn _: String, libraryIds _: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        if let error = searchLibraryBooksError {
            completion(.failure(error))
        } else {
            completion(.success(searchLibraryBooks))
        }
    }
}

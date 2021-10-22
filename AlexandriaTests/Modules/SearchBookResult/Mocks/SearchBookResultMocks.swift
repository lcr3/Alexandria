//
//  SearchBookResultMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/22.
//  
//

import CalilClient

@testable import Alexandria

final class MockSearchBookResultInteractor {
    init() {}
    var output: SearchBookResultInteractorOutput?
    var mockLibraryBooks: [LibraryBook] = []
    var mockError: Error?
}

extension MockSearchBookResultInteractor: SearchBookResultInteractorProtocol {
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String]) {
        if let error = mockError {
            self.output?.failureSearch(error)
        } else {
            self.output?.successSearch(mockLibraryBooks)
        }
    }
}

final class MockSearchBookResultPresenter: SearchBookResultPresenterProtocol {
    var isbn: String
    var libraryIds: [String]
    var title: String
    var libraryBooks: [LibraryBook]
    var isLoading: Bool
    var selectedBook: LibraryBook?
    private let interactor: SearchBookResultInteractorProtocol

    init(interactor: SearchBookResultInteractorProtocol, title: String, isbn: String = "", libraryIds: [String] = []) {
        self.interactor = interactor
        self.isbn = isbn
        self.libraryIds = libraryIds
        self.title = title
        libraryBooks = []
        isLoading = true
        interactor.searchForBooksInTheLibraries(isbn: isbn, libraryIds: libraryIds)
    }
}

extension MockSearchBookResultPresenter: SearchBookResultInteractorOutput {
    func successSearch(_ libraryBooks: [LibraryBook]) {
        isLoading = false
        self.libraryBooks = libraryBooks
    }

    func failureSearch(_: Error) {
        isLoading = false
        // TODO: error
    }
}

class MockCalilClient: CalilClientProtocol {
    var searchNearbyLibrariesLibrarys: [Library] = []
    var searchNearbyLibrariesError: Error?

    var searchLibraryBooks: [LibraryBook] = []
    var searchLibraryBooksError: Error?

    func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        if let error = searchNearbyLibrariesError {
            completion(.failure(error))
        } else {
            completion(.success(searchNearbyLibrariesLibrarys))
        }
    }

    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        if let error = searchLibraryBooksError {
            completion(.failure(error))
        } else {
            completion(.success(searchLibraryBooks))
        }
    }
}

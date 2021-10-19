//
//  SearchISBNMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/18.
//  
//

import ISBNClient
import StorageClient
@testable import Alexandria

final class MockSearchISBNInteractor: SearchISBNInteractorProtocol {

    init() {}

    var libraryIdsCalledCount = 0
    var searchBooksCalledCount = 0
    var deleteLocationCalledCount = 0
    var isSavedNearLibrariesCalledCount = 0
    var mockLibraryIds: [String] = []
    var mockIsSavedNearLibraries = false
    var output: SearchISBNInteractorOutput?

    func libraryIds() -> [String] {
        libraryIdsCalledCount += 1
        return mockLibraryIds
    }

    func searchBooks(name: String) {
        searchBooksCalledCount += 1
    }

    func deleteLocation() {
        deleteLocationCalledCount += 1
    }

    func isSavedNearLibraries() -> Bool {
        isSavedNearLibrariesCalledCount += 1
        return mockIsSavedNearLibraries
    }
}

extension MockSearchISBNPresenter: SearchISBNInteractorOutput {
    func successSearchBooks(_ books: [ISBNBook]) {
        self.books = books
    }

    func failureSearchBooks(_ error: SearchISBNError) {
        self.error = ErrorInfo(type: error)
    }
}

final class MockSearchISBNPresenter: SearchISBNPresenterProtocol {
    private let interactor: SearchISBNInteractorProtocol

    init(interactor: SearchISBNInteractorProtocol) {
        self.interactor = interactor
        books = []
        searchISBNBookName = ""
        isCurrentLocationNotSet = false
        mockLibraryIds = []
        isSearching = false
        isShowModal = false
        isShowDeleteLocationAlert = false
        error = nil
    }

    var books: [ISBNBook]
    var isSearching: Bool
    var isShowModal: Bool
    var isShowDeleteLocationAlert: Bool
    var error: ErrorInfo?
    var searchISBNBookName: String
    var isCurrentLocationNotSet: Bool
    var mockLibraryIds: [String]
    var searchButtonTappedCalledCount = 0
    var deleteButtonTappedCalledCount = 0
    var locationDeleteButtonTappedCalledCount = 0
    var locationDeleteAlertButtonTappedCalledCount = 0
    var isCurrentLocationNotSetAlertOKButtonTappedCalledCount = 0

    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
    }

    func searchButtonTapped() {
        searchButtonTappedCalledCount += 1
    }

    func deleteButtonTapped() {
        deleteButtonTappedCalledCount += 1
    }

    func locationDeleteButtonTapped() {
        locationDeleteButtonTappedCalledCount += 1
    }

    func locationDeleteAlertButtonTapped() {
        locationDeleteAlertButtonTappedCalledCount += 1
    }

    func isCurrentLocationNotSetAlertOKButtonTapped() {
        isCurrentLocationNotSetAlertOKButtonTappedCalledCount += 1
    }

    func libraryIds() -> [String] {
        return mockLibraryIds
    }
}

class MockStorageClient: StorageClientProtocol {
    var mockLibraryIds: [String] = []

    init() {
        mockLibraryIds = []
    }

    var libraryIds: [String] {
        return mockLibraryIds
    }

    func saveLibraryIds(_ ids: [String]) {
        self.mockLibraryIds = ids
    }

    func resetLibraryIds() {
        mockLibraryIds = []
    }

    func reset() {
        mockLibraryIds = []
    }
}

class MockISBNClient: ISBNClientProtocol {
    var isbnBooks: [ISBNBook]
    var error: Error?

    init() {
        self.isbnBooks = []
    }

    func searchISBN(title: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(isbnBooks))
        }
    }
}

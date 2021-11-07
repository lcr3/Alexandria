//
//  SearchISBNMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/18.
//
//

@testable import Alexandria
import ISBNClient
import StorageClient

final class MockSearchISBNInteractor: SearchISBNInteractorProtocol {
    init() {}

    var libraryIdsCalledCount = 0
    var searchBooksCalledCount = 0
    var deleteLocationCalledCount = 0
    var isSavedNearLibrariesCalledCount = 0
    var mockLibraryIds: [String] = []
    var mockSearchHistoryWords: [String] = []
    var mockIsSavedNearLibraries = false
    var output: SearchISBNInteractorOutput?

    func libraryIds() -> [String] {
        libraryIdsCalledCount += 1
        return mockLibraryIds
    }

    func searchHistoryWords() -> [String] {
        return mockSearchHistoryWords
    }

    func searchBooks(name _: String) {
        searchBooksCalledCount += 1
    }

    func deleteLocation() {
        deleteLocationCalledCount += 1
    }

    func isSavedNearLibraries() -> Bool {
        isSavedNearLibrariesCalledCount += 1
        return mockIsSavedNearLibraries
    }

    func saveSearch(word _: String) {}

    func fetchSearchHistoryWords() {}

    func featchSearchHistoryWords() {}

    func deleteHistory() {}
}

extension MockSearchISBNPresenter: SearchISBNInteractorOutput {
    func successSearchBooks(_ books: [ISBNBook]) {
        self.books = books
    }

    func failureSearchBooks(_ error: SearchISBNError) {
        self.error = ErrorInfo(type: error)
    }

    func featchSearchHistory(words: [String]) {
        searchHistoryWords = words
    }
}

final class MockSearchISBNPresenter: SearchISBNPresenterProtocol {
    private let interactor: SearchISBNInteractorProtocol

    init(interactor: SearchISBNInteractorProtocol) {
        self.interactor = interactor
        books = []
        searchHistoryWords = []
        searchISBNBookName = ""
        isCurrentLocationNotSet = false
        mockLibraryIds = []
        isSearching = false
        isShowModal = false
        isShowDeleteLocationAlert = false
        error = nil
    }

    var books: [ISBNBook]
    var searchHistoryWords: [String]
    var isSearching: Bool
    var isShowModal: Bool
    var isShowDeleteLocationAlert: Bool
    var error: ErrorInfo?
    var searchISBNBookName: String
    var isCurrentLocationNotSet: Bool
    var mockLibraryIds: [String]
    var onAppearCalledCount = 0
    var searchButtonTappedCalledCount = 0
    var deleteButtonTappedCalledCount = 0
    var searchHistoryCellTappedCalledCount = 0
    var locationDeleteButtonTappedCalledCount = 0
    var locationDeleteAlertButtonTappedCalledCount = 0
    var isCurrentLocationNotSetAlertOKButtonTappedCalledCount = 0
    var fetchSearchHistoryWordsCalledCount = 0
    var historyDeleteButtonTappedCalledCount = 0

    func onAppear() {
        onAppearCalledCount += 1
    }

    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
    }

    func searchButtonTapped() {
        searchButtonTappedCalledCount += 1
    }

    func deleteButtonTapped() {
        deleteButtonTappedCalledCount += 1
    }

    func searchHistoryCellTapped(word _: String) {
        searchHistoryCellTappedCalledCount += 1
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

    func fetchSearchHistoryWords() {
        fetchSearchHistoryWordsCalledCount += 1
    }

    func historyDeleteButtonTapped() {
        historyDeleteButtonTappedCalledCount += 1
    }
}

class MockStorageClient: StorageClientProtocol {
    var isHaveStarted: Bool
    var mockLibraryIds: [String]
    var mocksearchHistoryWords: [String]

    init() {
        mockLibraryIds = []
        mocksearchHistoryWords = []
        isHaveStarted = true
    }

    var libraryIds: [String] {
        return mockLibraryIds
    }

    var searchHistoryWords: [String] {
        return mocksearchHistoryWords
    }

    func saveLibraryIds(_ ids: [String]) {
        mockLibraryIds = ids
    }

    func saveSearchHistory(word: String) {
        mocksearchHistoryWords.append(word)
    }

    func saveIsHaveStarted() {
        isHaveStarted = true
    }

    func resetLibraryIds() {
        mockLibraryIds = []
    }

    func reset() {
        mockLibraryIds = []
    }

    func resetSearchHistory() {}
}

class MockISBNClient: ISBNClientProtocol {
    var isbnBooks: [ISBNBook]
    var error: Error?

    init() {
        isbnBooks = []
    }

    func searchISBN(title _: String, completion: @escaping (Result<[ISBNBook], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(isbnBooks))
        }
    }
}

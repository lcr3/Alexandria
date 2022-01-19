//
//  SearchISBNMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/18.
//
//

@testable import Alexandria
import Foundation
import CalilClient
import ISBNClient
import StorageClient

final class MockSearchISBNInteractor: SearchISBNInteractorProtocol {
    init() {}

    var libraryIdsCalledCount = 0
    var searchBooksCalledCount = 0
    var deleteLocationCalledCount = 0
    var isSavedLibrariesCalledCount = 0
    var mockSearchHistoryWords: [String] = []
    var mockIsSavedLibraries = false
    var output: SearchISBNInteractorOutput?
    func libraries() -> [Library] {
        []
    }

    func searchHistoryWords() -> [String] {
        mockSearchHistoryWords
    }

    func searchBooks(name _: String) {
        searchBooksCalledCount += 1
    }

    func deleteLocation() {
        deleteLocationCalledCount += 1
    }

    func isSavedLibraries() -> Bool {
        isSavedLibrariesCalledCount += 1
        return mockIsSavedLibraries
    }

    func saveSearch(word _: String) {}

    func fetchSearchHistoryWords() {}

    func featchSearchHistoryWords() {}

    func deleteHistory(index _: Int) {}

    func resetHistory() {}
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
        isSearching = false
        isShowModal = false
        isShowSetting = false
        isShowDeleteLocationAlert = false
        error = nil
    }

    var books: [ISBNBook]
    var searchHistoryWords: [String]
    var isSearching: Bool
    var isShowSetting: Bool
    var isShowModal: Bool
    var isShowDeleteLocationAlert: Bool
    var error: ErrorInfo?
    var searchISBNBookName: String
    var isCurrentLocationNotSet: Bool
    var onAppearCalledCount = 0
    var searchButtonTappedCalledCount = 0
    var deleteButtonTappedCalledCount = 0
    var searchHistoryCellTappedCalledCount = 0
    var locationDeleteButtonTappedCalledCount = 0
    var locationDeleteAlertButtonTappedCalledCount = 0
    var isCurrentLocationNotSetAlertOKButtonTappedCalledCount = 0
    var fetchSearchHistoryWordsCalledCount = 0
    var deleteHistoryCalledCount = 0
    var resetHistoryButtonTappedCalledCount = 0

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

    func fetchSearchHistoryWords() {
        fetchSearchHistoryWordsCalledCount += 1
    }

    func resetHistoryButtonTapped() {
        resetHistoryButtonTappedCalledCount += 1
    }

    func deleteHistory(index _: Int) {
        deleteHistoryCalledCount += 1
    }
}

class MockStorageClient: StorageClientProtocol {
    var isHaveStarted: Bool
    var mockLibraries: [Data]
    var mocksearchHistoryWords: [String]

    init() {
        mockLibraries = []
        mocksearchHistoryWords = []
        isHaveStarted = true
    }

    var libraries: [Data] {
        []
    }

    var searchHistoryWords: [String] {
        mocksearchHistoryWords
    }

    func saveLibraries(_: [Data]) {}

    func saveSearchHistory(word: String) {
        mocksearchHistoryWords.append(word)
    }

    func saveIsHaveStarted() {
        isHaveStarted = true
    }

    func resetLibraries() {
        mockLibraries = []
    }

    func reset() {
        mockLibraries = []
    }

    func resetSearchHistory() {}

    func deleteSearchHistory(index _: Int) {}
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

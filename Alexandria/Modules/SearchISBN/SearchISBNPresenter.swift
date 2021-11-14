import Combine
import ISBNClient
import SwiftUI

protocol SearchISBNPresenterProtocol {
    var searchISBNBookName: String { get set }
    var books: [ISBNBook] { get set }
    var searchHistoryWords: [String] { get }
    var isSearching: Bool { get set }
    var isShowModal: Bool { get set }
    var isCurrentLocationNotSet: Bool { get set }
    var isShowDeleteLocationAlert: Bool { get set }
    var error: ErrorInfo? { get set }

    func onAppear()
    func editSeachBookName(_ name: String)
    func searchButtonTapped()
    func deleteButtonTapped()
    func searchHistoryCellTapped(word: String)
    func historyDeleteButtonTapped()
    func locationDeleteButtonTapped()
    func locationDeleteAlertButtonTapped()
    func isCurrentLocationNotSetAlertOKButtonTapped()
    func libraryIds() -> [String]
}

final class SearchISBNPresenter: SearchISBNPresenterProtocol, ObservableObject {
    @Published var searchISBNBookName: String = ""
    @Published var books: [ISBNBook] = []
    @Published var isSearching = false
    @Published var isShowModal = false
    @Published var isCurrentLocationNotSet = false
    @Published var isShowDeleteLocationAlert = false
    @Published var error: ErrorInfo?
    @Published var searchHistoryWords: [String] = []

    private let interactor: SearchISBNInteractorProtocol

    init(interactor: SearchISBNInteractorProtocol) {
        self.interactor = interactor
        isShowModal = !interactor.isSavedNearLibraries()
    }
}

extension SearchISBNPresenter: SearchISBNViewProtocol {
    func onAppear() {
        interactor.featchSearchHistoryWords()
    }

    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
    }

    func searchButtonTapped() {
        if !interactor.isSavedNearLibraries() {
            isCurrentLocationNotSet = true
            return
        }
        if isSearching { return }
        if searchISBNBookName.isEmpty {
            error = .init(type: .titleNotEntered)
            return
        }
        isSearching = true
        interactor.searchBooks(name: searchISBNBookName)
    }

    func deleteButtonTapped() {
        searchISBNBookName = ""
    }

    func searchHistoryCellTapped(word: String) {
        searchISBNBookName = word
        searchButtonTapped()
    }

    func historyDeleteButtonTapped() {
        interactor.deleteHistory()
        interactor.featchSearchHistoryWords()
    }

    func isCurrentLocationNotSetAlertOKButtonTapped() {
        isCurrentLocationNotSet = false
        isShowModal = true
    }

    func locationDeleteButtonTapped() {
        isShowDeleteLocationAlert = true
    }

    func locationDeleteAlertButtonTapped() {
        interactor.deleteLocation()
        isCurrentLocationNotSet = false
        isShowModal = true
    }

    func libraryIds() -> [String] {
        interactor.libraryIds()
    }
}

extension SearchISBNPresenter: SearchISBNInteractorOutput {
    func successSearchBooks(_ books: [ISBNBook]) {
        isSearching = false
        self.books = books
    }

    func failureSearchBooks(_ error: SearchISBNError) {
        isSearching = false
        self.error = ErrorInfo(type: error)
    }

    func featchSearchHistory(words: [String]) {
        searchHistoryWords = words
    }
}

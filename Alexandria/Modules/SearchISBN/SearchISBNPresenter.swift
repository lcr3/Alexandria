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

    func editSeachBookName(_ name: String)
    func searchButtonTapped()
    func deleteButtonTapped()
    func searchHistoryCellTapped(word: String)
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
    var searchHistoryWords: [String] {
        interactor.searchHistoryWords()
    }

    private let interactor: SearchISBNInteractorProtocol
    
    init(interactor: SearchISBNInteractorProtocol) {
        self.interactor = interactor
        self.isShowModal = !interactor.isSavedNearLibraries()
    }
}

extension SearchISBNPresenter: SearchISBNViewProtocol {
    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
    }

    func searchButtonTapped() {
        if !interactor.isSavedNearLibraries() {
            isCurrentLocationNotSet = true
            return
        }
        if isSearching { return }
        if searchISBNBookName.isEmpty { return }
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
        self.isSearching = false
        self.books = books
    }

    func failureSearchBooks(_ error: SearchISBNError) {
        self.isSearching = false
        self.error = ErrorInfo(type: error)
    }
}

import Combine
import ISBNClient
import SwiftUI

protocol SearchISBNPresenterProtocol {
    var searchISBNBookName: String { get set }
    var isCurrentLocationNotSet: Bool { get }
    func editSeachBookName(_ name: String)
    func searchButtonTapped()
    func deleteButtonTapped()
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

    private let interactor: SearchISBNInteractorProtocol
    
    init(interactor: SearchISBNInteractorProtocol) {
        self.interactor = interactor
        self.isShowModal = !interactor.isSavedNearLibraries()
    }
}

extension SearchISBNPresenter: SearchISBNViewProtocol {
    func editSeachBookName(_ name: String) {
        searchISBNBookName = name
        isSearching = !searchISBNBookName.isEmpty
    }

    func searchButtonTapped() {
        if !interactor.isSavedNearLibraries() {
            isCurrentLocationNotSet = true
            return
        }

        if searchISBNBookName.isEmpty {
            return
        }
        interactor.searchBooks(name: searchISBNBookName)
    }

    func deleteButtonTapped() {
        searchISBNBookName = ""
        isSearching = false
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
        self.books = books
    }

    func failureSearchBooks(_ error: SearchISBNError) {
        self.error = ErrorInfo(type: error)
    }
}

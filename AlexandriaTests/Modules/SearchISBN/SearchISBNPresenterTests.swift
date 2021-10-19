//
//  SearchISBNPresenterTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/17.
//  
//

import XCTest
@testable import Alexandria

class SearchISBNPresenterTests: XCTestCase {

    var presenter: SearchISBNPresenter!
    var interactor: MockSearchISBNInteractor!

    override func setUpWithError() throws {
        super.setUp()

        interactor = MockSearchISBNInteractor()
        presenter = SearchISBNPresenter(interactor: interactor)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testEditSearchBookName() throws {
        // setup
        let editName = "abcdefg"
        XCTAssertEqual(presenter.isSearching, false)

        // execute
        presenter.editSeachBookName(editName)

        // verify
        XCTAssertEqual(presenter.searchISBNBookName, editName)
        XCTAssertEqual(presenter.isSearching, true)

        presenter.editSeachBookName("")
        XCTAssertEqual(presenter.searchISBNBookName, "")
        XCTAssertEqual(presenter.isSearching, false)
    }

    func testWhenLocationNotSetSearchButtonTapped() throws {
        // setup
        interactor.mockIsSavedNearLibraries = false
        XCTAssertEqual(presenter.isCurrentLocationNotSet, false)

        // execute
        presenter.searchButtonTapped()

        // verify
        XCTAssertEqual(presenter.isCurrentLocationNotSet, true)
        XCTAssertEqual(interactor.searchBooksCalledCount, 0)
    }

    func testWhenSearchISBMBookNameEmptySearchButtonTapped() throws {
        // setup
        interactor.mockIsSavedNearLibraries = true
        presenter.editSeachBookName("")

        // execute
        presenter.searchButtonTapped()

        // verify
        XCTAssertEqual(interactor.searchBooksCalledCount, 0)

        // execute
        presenter.editSeachBookName("abcdefg")
        presenter.searchButtonTapped()

        // verify
        XCTAssertEqual(interactor.searchBooksCalledCount, 1)
    }

    func testDeleteButtonTapped() throws {
        // setup
        presenter.editSeachBookName("abcdefg")
        XCTAssertEqual(presenter.searchISBNBookName, "abcdefg")
        XCTAssertEqual(presenter.isSearching, true)

        // execute
        presenter.deleteButtonTapped()

        // verify
        XCTAssertEqual(presenter.searchISBNBookName, "")
        XCTAssertEqual(presenter.isSearching, false)
    }

    func testIsCurrentLocationNotSetAlertOKButtonTapped() throws {
        // setup
        presenter.isCurrentLocationNotSet = true
        presenter.isShowModal = false

        // execute
        presenter.isCurrentLocationNotSetAlertOKButtonTapped()

        // verify
        XCTAssertEqual(presenter.isCurrentLocationNotSet, false)
        XCTAssertEqual(presenter.isShowModal, true)
    }

    func testLocationDeleteButtonTapped() throws {
        // setup
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, false)

        // execute
        presenter.locationDeleteButtonTapped()

        // verify
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, true)
    }

    func testLocationDeleteAlertButtonTapped() throws {
        // setup
        presenter.isCurrentLocationNotSet = true
        presenter.isShowModal = false
        XCTAssertEqual(interactor.deleteLocationCalledCount, 0)

        // execute
        presenter.locationDeleteAlertButtonTapped()

        // verify
        XCTAssertEqual(interactor.deleteLocationCalledCount, 1)
        XCTAssertEqual(presenter.isCurrentLocationNotSet, false)
        XCTAssertEqual(presenter.isShowModal, true)
    }

    func testLibraryIds() throws {
        // setup
        let libraryIds = ["1", "2", "3"]

        // execute
        interactor.mockLibraryIds = []

        // verify
        XCTAssertEqual(presenter.libraryIds(), [])
        interactor.mockLibraryIds = libraryIds
        XCTAssertEqual(presenter.libraryIds(), libraryIds)
    }
}

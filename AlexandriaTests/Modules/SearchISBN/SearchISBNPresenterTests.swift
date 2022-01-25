//
//  SearchISBNPresenterTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/17.
//
//

@testable import Alexandria
import XCTest

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

        presenter.editSeachBookName("")
        XCTAssertEqual(presenter.searchISBNBookName, "")
    }

    func testWhenLocationNotSetSearchButtonTapped() throws {
        // setup
        XCTAssertEqual(presenter.isCurrentLocationNotSet, false)

        // execute
        presenter.searchButtonTapped()

        // verify
        XCTAssertEqual(presenter.isCurrentLocationNotSet, true)
        XCTAssertEqual(interactor.searchBooksCalledCount, 0)
    }

    func testWhenSearchISBMBookNameEmptySearchButtonTapped() throws {
        // setup
        interactor.mockIsSavedLibraries = true
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

    func testLocationDeleteAlertButtonTapped() throws {
        // setup
        presenter.isCurrentLocationNotSet = true
        presenter.isShowModal = false
        XCTAssertEqual(interactor.deleteLocationCalledCount, 0)

        // execute
        presenter.locationDeleteAlertButtonTapped()

        // verify
        XCTAssertEqual(presenter.isCurrentLocationNotSet, false)
        XCTAssertEqual(presenter.isShowModal, true)
    }
}

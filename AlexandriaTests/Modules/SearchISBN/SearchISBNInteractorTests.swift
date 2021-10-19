//
//  SearchISBNInteractorTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/18.
//  
//

import ISBNClient
import XCTest
@testable import Alexandria

class SearchISBNInteractorTests: XCTestCase {
    var interctor: SearchISBNInteractor!
    var isbnClient: MockISBNClient!
    var presenter: MockSearchISBNPresenter!
    var storageClient: MockStorageClient!


    override func setUpWithError() throws {
        super.setUp()
        isbnClient = MockISBNClient()
        storageClient = MockStorageClient()

        interctor = SearchISBNInteractor(
            dependencies: SearchISBNInteractorDependencies(
                isbnClient: isbnClient,
                storegeClient: storageClient
            )
        )
        presenter = MockSearchISBNPresenter(interactor: interctor)
        interctor.output = presenter
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testLibraryIds() throws {
        // setup
        let libraryIds = ["1", "2"]
        XCTAssertEqual(interctor.libraryIds(), [])

        // execute
        storageClient.mockLibraryIds = libraryIds

        // verify
        XCTAssertEqual(interctor.libraryIds(), libraryIds)
    }

    func testSuccessSearchBooks() {
        // setup
        let name = "aaaa"
        let book1 = ISBNBook(title: "book1", author: "author1", isbn: "1", imageUrl: "1")
        let book2 = ISBNBook(title: "book2", author: "author2", isbn: "2", imageUrl: "2")
        isbnClient.isbnBooks = [book1, book2]

        // execute
        interctor.searchBooks(name: name)

        // verify
        XCTAssertEqual(presenter.books, [book1, book2])
        XCTAssertEqual(presenter.error, nil)
    }

    func testNoMatchSearchBooks() {
        // setup
        let name = "aaaa"
        let error = SearchISBNError.noMatch

        // execute
        interctor.searchBooks(name: name)

        // verify
        XCTAssertEqual(presenter.error?.title, error.title)
        XCTAssertEqual(presenter.error?.description, error.description)
        XCTAssertEqual(presenter.books, [])
    }

    func testDeleteLocation() {
        // setup
        let expectLibraryIds = ["1", "2"]
        storageClient.mockLibraryIds = expectLibraryIds
        XCTAssertEqual(interctor.libraryIds(), expectLibraryIds)

        // execute
        interctor.deleteLocation()

        // verify
        XCTAssertEqual(interctor.libraryIds(), [])
    }

    func testIsSavedNearLibraries() {
        // setup
        XCTAssertEqual(interctor.isSavedNearLibraries(), false)

        // execute
        storageClient.mockLibraryIds = ["1", "2"]

        // verify
        XCTAssertEqual(interctor.isSavedNearLibraries(), true)
    }
}


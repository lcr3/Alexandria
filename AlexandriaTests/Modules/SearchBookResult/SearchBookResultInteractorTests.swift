//
//  SearchBookResultInteractorTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/22.
//  
//

import CalilClient
import XCTest
@testable import Alexandria

class SearchBookResultInteractorTests: XCTestCase {

    var interactor: SearchBookResultInteractorProtocol!
    var presenter: MockSearchBookResultPresenter!
    var calilClient: MockCalilClient!
    var storageClient: MockStorageClient!

    override func setUpWithError() throws {
        super.setUp()
        calilClient = MockCalilClient()
        storageClient = MockStorageClient()

        interactor = SearchBookResultInteractor(
            dependencies: SearchBookResultInteractorDependencies(
                calilClient: calilClient,
                storageClient: storageClient
            )
        )
        presenter = MockSearchBookResultPresenter(
            interactor: interactor,
            title: "タイトル",
            isbn: "123456789",
            libraryIds: ["1", "2", "3"]
        )
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testSuccessSearchBooks() throws {
        // setup
        let libraryBook1 = LibraryBook(
            name: "Tokyo_Chiyoda",
            systemName: "東京都千代田区",
            state: "Cache",
            libraryStates: [
                LibraryState(name: "千代田", state: .loan),
                LibraryState(name: "四番町", state: .available),
                LibraryState(name: "日比谷", state: .availableInTheLibrary)
            ]
        )
        calilClient.searchLibraryBooks = [libraryBook1]
        XCTAssertEqual(presenter.isLoading, true)
        XCTAssertEqual(presenter.libraryBooks.count, 0)

        // execute
        interactor.searchForBooksInTheLibraries(isbn: "タイトル", libraryIds: [])

        // verify
        XCTAssertEqual(presenter.isLoading, false)
        XCTAssertEqual(presenter.libraryBooks.count, 1)
        let resultLibraryBook = presenter.libraryBooks.first
        XCTAssertEqual(resultLibraryBook?.name, libraryBook1.name)
        XCTAssertEqual(resultLibraryBook?.systemName, libraryBook1.systemName)
        XCTAssertEqual(resultLibraryBook?.libraryStates.first?.name, "千代田")
        XCTAssertEqual(resultLibraryBook?.libraryStates.first?.state, .loan)
    }
}

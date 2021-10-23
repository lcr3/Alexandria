//
//  SearchBookResultPresenterTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2021/10/24.
//  
//

import CalilClient
import XCTest

@testable import Alexandria

class SearchBookResultPresenterTests: XCTestCase {

    var interactor: MockSearchBookResultInteractor!
    var presenter: SearchBookResultPresenter!

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testExample() throws {
        interactor = MockSearchBookResultInteractor()
        XCTAssertEqual(interactor.searchForBooksInTheLibrariesCallCount, 0)
        let libraryBook = LibraryBook(
            name: "Tokyo_Chiyoda",
            systemName: "東京都千代田区",
            state: "Cache",
            libraryStates: [
                LibraryState(name: "千代田", state: .loan),
                LibraryState(name: "四番町", state: .available),
                LibraryState(name: "日比谷", state: .availableInTheLibrary)
            ]
        )
        interactor.mockLibraryBooks = [libraryBook]
        presenter = SearchBookResultPresenter(
            interactor: interactor,
            title: "title",
            isbn: "123456789",
            libraryIds: ["1", "2", "3"]
        )
        interactor.output = presenter


        XCTAssertEqual(interactor.searchForBooksInTheLibrariesCallCount, 1)
    }
}

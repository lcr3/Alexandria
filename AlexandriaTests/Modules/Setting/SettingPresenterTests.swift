//
//  SettingPresenterTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2022/01/25.
//

import CalilClient
import XCTest
@testable import Alexandria

class SettingPresenterTests: XCTestCase {
    var presenter: SettingPresenter!
    var interactor: MockSettingInteractor!

    override func setUpWithError() throws {
        super.setUp()
        interactor = MockSettingInteractor()
        presenter = SettingPresenter(interactor: interactor)
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testGetSaveLibraries() throws {
        // setup
        XCTAssertEqual(presenter.savedLibraries, [])
        let expectLibraries = [
            Library(name: "1"),
            Library(name: "2")
        ]
        interactor.mockLibraries = expectLibraries

        // excute
        presenter.getSaveLibraries()

        // verify
        XCTAssertEqual(presenter.savedLibraries, expectLibraries)
    }


    func testResetButtonTouched() throws {
        // setup
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, false)

        // execute
        presenter.resetButtonTouched()

        // verify
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, true)
    }

    func testLocationDeleteAlertButtonTapped() throws {
        // setup
        presenter.resetButtonTouched()
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, true)

        // execute
        presenter.locationDeleteAlertButtonTapped()

        // verify
        XCTAssertEqual(presenter.isShowDeleteLocationAlert, false)
    }
}

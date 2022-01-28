//
//  SettingInteractorTests.swift
//  AlexandriaTests
//
//  Created by lcr on 2022/01/25.
//

import CalilClient
import XCTest
@testable import Alexandria

class SettingInteractorTests: XCTestCase {
    var presenter: MockSettingPresenter!
    var interactor: SettingInteractor!
    var storageClient: MockStorageClient!

    override func setUpWithError() throws {
        super.setUp()
        storageClient = MockStorageClient()
        interactor = SettingInteractor(
            dependencies: SettingInteractorDependencies(
                storegeClient: storageClient
            )
        )
        presenter = MockSettingPresenter()
        interactor.output = presenter
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testSuccessGetSavedLibraries() {
        // setup
        let expectLibraries = [
            Library(name: "1"),
            Library(name: "2")
        ]
        var dataLibs: [Data] = []
        expectLibraries.forEach { library in
            do {
                let data = try JSONEncoder().encode(library)
                dataLibs.append(data)
            } catch {
                fatalError()
            }
        }
        storageClient.mockLibraries = dataLibs

        // execute
        interactor.getSaveLibraries()

        // verify
        XCTAssertEqual(presenter.savedLibraries, expectLibraries)
    }

    func testFailureGetLibraries() {
        let expectError = SettingInteractorError.failedDecode
        storageClient.mockLibraries = [Data()]


        // execute
        interactor.getSaveLibraries()

        // verify
        XCTAssertEqual(presenter.savedLibraries, [])
        XCTAssertEqual(presenter.error, expectError)
    }
}

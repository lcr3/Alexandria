@testable import CalilClient
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class CalilClientTests: XCTestCase {
    var client: CalilClient!

    override func setUpWithError() throws {
        super.setUp()
        client = CalilClient()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        HTTPStubs.removeAllStubs()
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }

    func testSuccessSearchLibrary() throws {
        // setup
        let testExpectation = expectation(description: "testSuccessResponse")
        stub(condition: pathEndsWith("/library")) { _ in
            HTTPStubsResponse(
                jsonObject: MockJsonResponse.success,
                statusCode: 200,
                headers: nil
            )
        }

        // execute
        client.searchNearbyLibraries(latitude: 35.6895014, longitude: 139.6917337) { result in
            switch result {
            case let .success(libraries):
                // verify
                let library = libraries.first
                XCTAssertEqual(libraries.count, 5)
                XCTAssertEqual(library?.name, "千代田区立神田まちかど図書館")
                XCTAssertEqual(library?.address, "東京都千代田区神田司町2-16 神田さくら館内")
                XCTAssertEqual(library?.pref, "東京都")
                XCTAssertEqual(library?.libid, "103877")
                XCTAssertEqual(library?.systemId, "Tokyo_Chiyoda")
                XCTAssertEqual(library?.systemName, "東京都千代田区")
                XCTAssertEqual(library?.category, "MEDIUM")

                XCTAssertEqual(UserDefaults.standard.string(forKey: "Tokyo_Chiyoda"), "千代田区立神田まちかど図書館")
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Special_Sonposoken"), "損害保険事業総合研究所図書館")
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Nihon_Rik"), "日本大学理工学部駿河台図書館")
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Nihon_Den"), "日本大学図書館歯学部分館")
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Tmd"), "東京医科歯科大学図書館")
            case .failure:
                XCTFail("Unexpected error")
            }
            testExpectation.fulfill()
        }
        wait(for: [testExpectation], timeout: 3.0)
    }

    func testFailerSearchLibrary() throws {
        // setup
        let testExpectation = expectation(description: "testSuccessResponse")
        stub(condition: pathEndsWith("/library")) { _ in
            HTTPStubsResponse(
                error: NSError(
                    domain: NSURLErrorDomain,
                    code: URLError.notConnectedToInternet.rawValue
                )
            )
        }

        // execute
        client.searchNearbyLibraries(latitude: 35.6895014, longitude: 139.6917337) { result in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure:
                // verify
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Tokyo_Chiyoda"), nil)
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Special_Sonposoken"), nil)
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Nihon_Rik"), nil)
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Nihon_Den"), nil)
                XCTAssertEqual(UserDefaults.standard.string(forKey: "Univ_Tmd"), nil)
            }
            testExpectation.fulfill()
        }
        wait(for: [testExpectation], timeout: 3.0)
    }

    func testSuccessSearchBook() throws {
        // setup
        let testExpectation = expectation(description: "testSuccessResponse")
        stub(condition: pathEndsWith("/check")) { _ in
            HTTPStubsResponse(
                jsonObject: MockJsonResponse.finishSuccess,
                statusCode: 200,
                headers: nil
            )
        }

        client.searchForBooksInTheLibraries(isbn: "4334926940", libraryIds: []) { result in
            switch result {
            case let .success(libraryBooks):
                XCTAssertEqual(libraryBooks.count, 5)
            case .failure:
                XCTFail("Unexpected error")
            }
            testExpectation.fulfill()
        }
        wait(for: [testExpectation], timeout: 3.0)
    }
}

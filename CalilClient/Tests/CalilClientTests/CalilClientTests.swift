import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import CalilClient

final class CalilClientTests: XCTestCase {
    var client: CalilClient!

    override func setUpWithError() throws {
        super.setUp()
        client = CalilClient()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }

    func testSuccessResponse() throws {
        // setup
        let testExpectation = expectation(description: "testSuccessResponse")
        stub(condition: pathEndsWith("/library")) { _ in
            return HTTPStubsResponse(
                jsonObject: MockJsonResponse.success,
                statusCode: 200,
                headers: nil
            )
        }

        // execute
        client.searchNearbyLibraries(latitude: 35.6895014, longitude: 139.6917337) { result in
            switch result {
            case .success(let libraries):
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
            case .failure(_):
                XCTFail("Unexpected error")
            }
            testExpectation.fulfill()
        }
        wait(for: [testExpectation], timeout: 3.0)
    }
}

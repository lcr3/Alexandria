@testable import ISBNClient
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class ISBNClientTests: XCTestCase {
    var client: ISBNClient!

    override func setUpWithError() throws {
        super.setUp()
        client = ISBNClient(apiKey: "")
    }

    override func tearDownWithError() throws {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }

    func testSuccessResponse() throws {
        // setup
        let testExpectation = expectation(description: "testSuccessResponse")
        stub(condition: pathEndsWith("/20170404")) { _ in
            HTTPStubsResponse(
                jsonObject: MockJsonResponse.success,
                statusCode: 200,
                headers: nil
            )
        }

        // execute
        client.searchISBN(title: "Mock word") { result in
            switch result {
            case let .success(books):
                // verify
                XCTAssertEqual(books.count, 3)
                XCTAssertEqual(books.first?.title, "社会人大学人見知り学部 卒業見込み")
                XCTAssertEqual(books.first?.author, "若林正恭")
                XCTAssertEqual(books.first?.isbn, "4041026148")
            case .failure:
                XCTFail("Unexpected error")
            }
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 3.0)
    }
}

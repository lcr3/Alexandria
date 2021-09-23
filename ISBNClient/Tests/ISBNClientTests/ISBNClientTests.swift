import XCTest
@testable import ISBNClient

final class ISBNClientTests: XCTestCase {

    var client: ISBNClient!

    override func setUpWithError() throws {
        super.setUp()
        client = ISBNClient()
    }

    func testExample() throws {
        let expectation = XCTestExpectation(description: "Download apple.com home page")

        client.searchISBN(title: "三体") { result in
            switch result {
            case .success(let books):
                print(books)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 3.0)
    }
}

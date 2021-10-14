import XCTest
@testable import StorageClient

final class StorageClientTests: XCTestCase {
    var client: StorageClient!

    override func setUp() {
        super.setUp()
        client = StorageClient()
        client.reset()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSetGetLibraryIds() throws {
        // Test init value
        XCTAssertEqual(client.libraryIds, [])

        // Execute
        var expectLibraryIds = ["lib_1", "lib_2", "lib_3", "lib_4"]
        client.saveLibraryIds(expectLibraryIds)

        // Verify
        XCTAssertEqual(client.libraryIds, expectLibraryIds)

        expectLibraryIds = ["lib_10", "lib_20", "lib_30"]
        client.saveLibraryIds(expectLibraryIds)

        // Verify
        XCTAssertEqual(client.libraryIds, expectLibraryIds)
    }

    func testReset() throws {
        // Test init value
        XCTAssertEqual(client.libraryIds, [])

        let expectLibraryIds = ["lib_1", "lib_2", "lib_3", "lib_4"]
        client.saveLibraryIds(expectLibraryIds)

        XCTAssertEqual(client.libraryIds, expectLibraryIds)

        client.reset()

        XCTAssertEqual(client.libraryIds, [])
    }
}

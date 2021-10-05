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

    func testSetGetLocation() throws {
        // Test init value
        XCTAssertEqual(client.location.latitude, 0)
        XCTAssertEqual(client.location.longitude, 0)

        // Execute
        var expectLatiude = 123.934534
        var expectLongitude = 35.0012012
        client.saveLocation(latitude: expectLatiude, longitude: expectLongitude)

        // Verify
        XCTAssertEqual(client.location.latitude, expectLatiude)
        XCTAssertEqual(client.location.longitude, expectLongitude)

        expectLatiude = 124.1233453
        expectLongitude = 36.453434
        client.saveLocation(latitude: expectLatiude, longitude: expectLongitude)
        XCTAssertEqual(client.location.latitude, expectLatiude)
        XCTAssertEqual(client.location.longitude, expectLongitude)
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
        XCTAssertEqual(client.location.latitude, 0)
        XCTAssertEqual(client.location.longitude, 0)

        let expectLatiude = 123.934534
        let expectLongitude = 35.0012012
        client.saveLocation(latitude: expectLatiude, longitude: expectLongitude)
        XCTAssertEqual(client.location.latitude, expectLatiude)
        XCTAssertEqual(client.location.longitude, expectLongitude)

        client.reset()

        XCTAssertEqual(client.location.latitude, 0)
        XCTAssertEqual(client.location.longitude, 0)
    }
}

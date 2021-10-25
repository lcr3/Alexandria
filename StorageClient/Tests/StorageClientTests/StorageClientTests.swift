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

    func testResetLibraryId() throws {
        // Test init value
        let expectLibraryIds = ["lib_1", "lib_2", "lib_3", "lib_4"]
        client.saveLibraryIds(expectLibraryIds)

        // Verify
        XCTAssertEqual(client.libraryIds, expectLibraryIds)

        // Execute
        client.resetLibraryIds()

        // Verify
        XCTAssertEqual(client.libraryIds, [])
    }

    func testSearchHistory() throws {
        // Test init value
        let expectSearchWord1 = "word1"
        let expectSearchWord2 = "word2"
        let expectSearchWord3 = "word3"
        let expectSearchWord4 = "word4"
        let expectSearchWord5 = "word5"
        let expectSearchWord6 = "word6"
        XCTAssertEqual(client.searchHistoryWords, [])

        // Execute
        client.saveSearchHistory(word: expectSearchWord1)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 1)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord1)

        client.saveSearchHistory(word: expectSearchWord2)
        client.saveSearchHistory(word: expectSearchWord3)
        client.saveSearchHistory(word: expectSearchWord4)
        client.saveSearchHistory(word: expectSearchWord5)
        client.saveSearchHistory(word: expectSearchWord6)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 5)
        XCTAssertEqual(client.searchHistoryWords[0], expectSearchWord2)
        XCTAssertEqual(client.searchHistoryWords[1], expectSearchWord3)
        XCTAssertEqual(client.searchHistoryWords[2], expectSearchWord4)
        XCTAssertEqual(client.searchHistoryWords[3], expectSearchWord5)
        XCTAssertEqual(client.searchHistoryWords[4], expectSearchWord6)
    }

    func testAlreadySearchWord() throws {
        // Test init value
        let expectSearchWord1 = "word1"
        XCTAssertEqual(client.searchHistoryWords, [])

        // Execute
        client.saveSearchHistory(word: expectSearchWord1)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 1)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord1)

        client.saveSearchHistory(word: expectSearchWord1)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 1)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord1)
    }

    func testReset() throws {
        // Test init value
        XCTAssertEqual(client.libraryIds, [])

        let expectLibraryIds = ["lib_1", "lib_2", "lib_3", "lib_4"]
        let expectSearchWord = "word"
        client.saveLibraryIds(expectLibraryIds)
        client.saveSearchHistory(word: expectSearchWord)

        XCTAssertEqual(client.libraryIds, expectLibraryIds)
        XCTAssertEqual(client.searchHistoryWords, [expectSearchWord])

        client.reset()

        XCTAssertEqual(client.libraryIds, [])
        XCTAssertEqual(client.searchHistoryWords, [])
    }
}

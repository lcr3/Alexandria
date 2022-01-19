@testable import StorageClient
import XCTest

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

    func testGetLibraries() throws {
        // Test init value
        XCTAssertEqual(client.libraries, [])

        // Execute
        var expectLibraries = [Data(), Data(), Data()]
        client.saveLibraries(expectLibraries)

        // Verify
        XCTAssertEqual(client.libraries, expectLibraries)

        expectLibraries = [Data(), Data()]
        client.saveLibraries(expectLibraries)

        // Verify
        XCTAssertEqual(client.libraries, expectLibraries)
    }

    func testResetLibraries() throws {
        // Test init value
        let expectLibraries = [Data(), Data(), Data()]
        client.saveLibraries(expectLibraries)

        // Verify
        XCTAssertEqual(client.libraries, expectLibraries)

        // Execute
        client.resetLibraries()

        // Verify
        XCTAssertEqual(client.libraries, [])
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

    func testDeleteSearchHistory() throws {
        // Test init value
        let expectSearchWord1 = "word1"
        let expectSearchWord2 = "word2"
        let expectSearchWord3 = "word3"
        client.saveSearchHistory(word: expectSearchWord1)
        client.saveSearchHistory(word: expectSearchWord2)
        client.saveSearchHistory(word: expectSearchWord3)
        XCTAssertEqual(client.searchHistoryWords, [expectSearchWord1, expectSearchWord2, expectSearchWord3])

        // Execute
        client.deleteSearchHistory(index: 1)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 2)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord1)
        XCTAssertEqual(client.searchHistoryWords.last, expectSearchWord3)

        // Execute
        client.deleteSearchHistory(index: 0)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 1)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord3)
    }

    func testResetSearchHistoryWords() throws {
        // Test init value
        let expectSearchWord1 = "word1"
        XCTAssertEqual(client.searchHistoryWords, [])

        // Execute
        client.saveSearchHistory(word: expectSearchWord1)

        // Verify
        XCTAssertEqual(client.searchHistoryWords.count, 1)
        XCTAssertEqual(client.searchHistoryWords.first, expectSearchWord1)

        client.resetSearchHistory()

        // Verify
        XCTAssertEqual(client.searchHistoryWords, [])
    }

    func testIsHaveStarted() throws {
        // Test init value
        XCTAssertEqual(client.isHaveStarted, true)

        // Execute
        client.saveIsHaveStarted()

        // Verify
        XCTAssertEqual(client.isHaveStarted, false)

        client.reset()

        // Verify
        XCTAssertEqual(client.isHaveStarted, true)
    }

    func testReset() throws {
        // Test init value
        XCTAssertEqual(client.libraries, [])

        let expectLibraries = [Data(), Data(), Data()]
        let expectSearchWord = "word"
        client.saveLibraries(expectLibraries)
        client.saveSearchHistory(word: expectSearchWord)

        XCTAssertEqual(client.libraries, expectLibraries)
        XCTAssertEqual(client.searchHistoryWords, [expectSearchWord])

        client.reset()

        XCTAssertEqual(client.libraries, [])
        XCTAssertEqual(client.searchHistoryWords, [])
    }
}

import Foundation

public protocol StorageClientProtocol {
    var libraryIds: [String] { get }
    var searchHistoryWords: [String] { get }
    var isHaveStarted: Bool { get }

    func saveLibraryIds(_ ids: [String])
    func resetLibraryIds()
    func resetSearchHistory()
    func saveSearchHistory(word: String)
    func saveIsHaveStarted()
    func reset()
}

public struct StorageClient {
    private let userDafaults: UserDefaults
    private let libraryIdsKey = "library_ids_key"
    private let searchHistoryWordsKey = "serch_history_words_key"
    private let isHaveStartedKey = "is_have_start_key"
    private let maxSerchHistoryCount = 5

    public init() {
        userDafaults = UserDefaults.standard
    }
}

extension StorageClient: StorageClientProtocol {
    public var libraryIds: [String] {
        guard let ids = userDafaults.array(forKey: libraryIdsKey) as? [String] else {
            return []
        }
        return ids
    }

    public var searchHistoryWords: [String] {
        guard let histories = userDafaults.array(forKey: searchHistoryWordsKey) as? [String] else {
            return []
        }
        return histories
    }

    public var isHaveStarted: Bool {
        return !userDafaults.bool(forKey: isHaveStartedKey)
    }

    public func saveLibraryIds(_ ids: [String]) {
        userDafaults.set(ids, forKey: libraryIdsKey)
    }

    public func resetLibraryIds() {
        userDafaults.removeObject(forKey: libraryIdsKey)
    }

    public func saveSearchHistory(word: String) {
        var searchWords = searchHistoryWords
        if searchWords.contains(word) {
            return
        }
        if searchWords.count >= maxSerchHistoryCount {
            searchWords.remove(at: 0)
        }
        searchWords.append(word)
        userDafaults.set(searchWords, forKey: searchHistoryWordsKey)
    }

    public func resetSearchHistory() {
        userDafaults.set([], forKey: searchHistoryWordsKey)
    }

    public func saveIsHaveStarted() {
        userDafaults.set(true, forKey: isHaveStartedKey)
    }

    public func reset() {
        guard let appDomain = Bundle.main.bundleIdentifier else {
            fatalError("domain is nil.")
        }
        userDafaults.removePersistentDomain(forName: appDomain)
    }
}

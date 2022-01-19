import Foundation

public protocol StorageClientProtocol {
    var libraries: [Data] { get }
    var searchHistoryWords: [String] { get }
    var isHaveStarted: Bool { get }

    func saveLibraries(_ datas: [Data])
    func resetLibraries()
    func deleteSearchHistory(index: Int)
    func resetSearchHistory()
    func saveSearchHistory(word: String)
    func saveIsHaveStarted()
    func reset()
}

public struct StorageClient {
    private let userDafaults: UserDefaults
    private let librariesKey = "libraries_key"
    private let searchHistoryWordsKey = "serch_history_words_key"
    private let isHaveStartedKey = "is_have_start_key"
    private let maxSerchHistoryCount = 5

    public init() {
        userDafaults = UserDefaults.standard
    }
}

extension StorageClient: StorageClientProtocol {
    public var libraries: [Data] {
        guard let livs = userDafaults.array(forKey: librariesKey) as? [Data] else {
            return []
        }
        return livs
    }

    public var searchHistoryWords: [String] {
        guard let histories = userDafaults.array(forKey: searchHistoryWordsKey) as? [String] else {
            return []
        }
        return histories
    }

    public var isHaveStarted: Bool {
        !userDafaults.bool(forKey: isHaveStartedKey)
    }

    public func saveLibraries(_ datas: [Data]) {
        userDafaults.set(datas, forKey: librariesKey)
    }

    public func resetLibraries() {
        userDafaults.removeObject(forKey: librariesKey)
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

    public func deleteSearchHistory(index: Int) {
        var historyWords = searchHistoryWords
        historyWords.remove(at: index)
        userDafaults.set(historyWords, forKey: searchHistoryWordsKey)
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

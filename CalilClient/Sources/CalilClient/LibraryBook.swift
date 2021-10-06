import APIKit
import Foundation

public struct LibraryBook: Decodable, Identifiable {
    public var id: UUID = UUID()
    public let name: String
    public let state: String
    public let reserveUrl: String
    public let libraryStates: [LibraryState]

    public init(object: Any) throws {
        guard let dictionary = object as? (String, [String: Any]),
              let status = dictionary.1["status"] as? String,
              let libKeys = dictionary.1["libkey"] as? [String: Any],
              let reserveUrl = dictionary.1["reserveurl"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        var libraryStates: [LibraryState] = []
        try libKeys.forEach { libraryState in
            libraryStates.append(try LibraryState(object: libraryState))
        }
        self.name = dictionary.0
        self.state = status
        self.reserveUrl = reserveUrl
        self.libraryStates = libraryStates
    }
}

public struct LibraryState: Decodable, Identifiable {
    public var id = UUID()
    public let name: String
    public let state: BookState

    public init(object: Any) throws {
        guard let dictionary = object as? (String, String),
              let state = BookState(rawValue: dictionary.1) else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.name = dictionary.0
        self.state = state
    }
}

public enum BookState: String, Decodable {
    case available = "貸出可"
    case availableInTheLibrary = "蔵書あり"
    case onlyInTheLibrary = "館内のみ"
    case loan = "貸出中"
    case reserve = "予約中"
    case preparation = "準備中"
    case closed = "休館中"
    case none = "蔵書なし"
    case unknown = "不明"
}

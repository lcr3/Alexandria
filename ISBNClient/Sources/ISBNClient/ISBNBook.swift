import APIKit
import Foundation

public struct ISBNBook: Identifiable {
    public var id = UUID()
    public var title: String
    public var author: String
    public var isbn: String
    public var imageUrl: String

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let title = dictionary["title"] as? String,
              let author = dictionary["author"] as? String,
              let isbn = dictionary["isbn"] as? String,
              let imageUrl = dictionary["smallImageUrl"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.title = title
        self.author = author
        self.isbn = isbn
        self.imageUrl = imageUrl
    }

    public init(id: UUID = UUID(), title: String = "", author: String = "", isbn: String = "", imageUrl: String = "") {
        self.id = id
        self.title = title
        self.author = author
        self.isbn = isbn
        self.imageUrl = imageUrl
    }
}

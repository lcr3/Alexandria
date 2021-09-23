import APIKit

public struct ISBNBook {
    var title: String
    var author: String
    var isbn: String

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let title = dictionary["title"] as? String,
              let author = dictionary["author"] as? String,
              let isbn = dictionary["isbn"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.title = title
        self.author = author
        self.isbn = isbn
    }
}

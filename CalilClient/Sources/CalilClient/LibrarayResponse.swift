import APIKit

struct LibrarayResponse: Decodable {
    // 2回目以降のリクエスト時にパラメータに追加する
    let session: String
    // すべての検索が完了しているか
    var isFinish: Bool
    let libraryBooks: [LibraryBook]

    public init(object: Any) throws {
        print(object)

        guard let dictionary = object as? [String: Any],
              let session = dictionary["session"] as? String,
              let continueValue = dictionary["continue"] as? Int,
              let books = dictionary["books"] as? [String: [String: [String: Any]]]
        else {
            throw ResponseError.unexpectedObject(object)
        }

        self.session = session
        isFinish = continueValue == 0
        if isFinish {
            guard let info = books.first?.value else {
                throw ResponseError.unexpectedObject(object)
            }
            var books: [LibraryBook] = []
            try info.forEach { result in
                books.append(try LibraryBook(object: result))
            }

            libraryBooks = books
        } else {
            libraryBooks = []
        }
    }
}

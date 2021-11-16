import APIKit
import Foundation

public protocol CalilClientProtocol {
    func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void)
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void)
}

public struct CalilClient {
    private let requestInterval = 2.5
    private let libraryNameClient: LibraryNameClient
    private let apiKey: String
    public init(apiKey: String) {
        self.apiKey = apiKey
        libraryNameClient = LibraryNameClient()
    }
}

extension CalilClient: CalilClientProtocol {
    public func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        let request = SearchNearbyLibrariesRequest(
            apiKey: apiKey,
            latitude: latitude,
            longitude: longitude
        )
        Session.send(request) { result in
            switch result {
            case let .success(libraries):
                libraries.forEach { library in
                    libraryNameClient.set(name: library.name, key: library.systemId)
                }
                completion(.success(libraries))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        print("isbn: \(isbn)| ids: \(libraryIds)")
        // polling処理をcompletionで解決したいのでrequestメソッド内にpollメソッドを書いている
        let request = SearchForBooksInTheLibrariesRequest(
            apiKey: apiKey,
            isbn: isbn,
            libraryIds: libraryIds
        )

        func poll(session _: String = "") {
            Session.send(request) { result in
                switch result {
                case let .success(response):
                    if response.isFinish {
                        print("検索終了")
                        var fixLibraryBooks: [LibraryBook] = []
                        for var libraryBook in response.libraryBooks {
                            libraryBook.name = libraryNameClient.get(key: libraryBook.systemName)
                            fixLibraryBooks.append(libraryBook)
                        }
                        completion(.success(fixLibraryBooks))
                    } else {
                        print("検索続行")
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.requestInterval) {
                            // 検索がまだ完了していないのでインターバルをおいた後再度リクエスト
                            poll(session: response.session)
                        }
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        poll()
    }
}

/*
 図書検索で返ってくるデータに図書館の名前が紐付いていないため
 図書館検索時に取得した図書館名を保存しておく
 */
struct LibraryNameClient {
    private let userDafaults: UserDefaults

    public init() {
        userDafaults = UserDefaults.standard
    }

    public func get(key: String) -> String {
        guard let name = userDafaults.string(forKey: key) else {
            return ""
        }
        return name
    }

    public func set(name: String, key: String) {
        userDafaults.set(name, forKey: key)
    }
}

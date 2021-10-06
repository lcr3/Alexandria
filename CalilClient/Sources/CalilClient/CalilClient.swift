import APIKit
import Foundation

public protocol CalilClientProtocol {
    func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void)
    func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void)
}

public struct CalilClient {
    public init() {}
    private let requestInterval = 2.5
}

extension CalilClient: CalilClientProtocol {
    public func searchNearbyLibraries(latitude: Double, longitude: Double, completion: @escaping (Result<[Library], Error>) -> Void) {
        let request = SearchNearbyLibrariesRequest(latitude: latitude, longitude: longitude)
        Session.send(request) { result in
            switch result {
            case .success(let libraries):
                completion(.success(libraries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func searchForBooksInTheLibraries(isbn: String, libraryIds: [String], completion: @escaping (Result<[LibraryBook], Error>) -> Void) {
        print("isbn: \(isbn)| ids: \(libraryIds)")
        // polling処理をcompletionで解決したいのでrequestメソッド内にpollメソッドを書いている
        let request = SearchForBooksInTheLibrariesRequest(
            isbn: isbn,
            libraryIds: libraryIds
        )

        func poll(session: String = "") {
            Session.send(request) { result in
                switch result {
                case .success(let response):
                    if response.isFinish {
                        print("検索終了")
                        completion(.success(response.libraryBooks))
                    } else {
                        print("検索続行")
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.requestInterval) {
                            // 検索がまだ完了していないのでインターバルをおいた後再度リクエスト
                            poll(session: response.session)
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        poll()
    }
}


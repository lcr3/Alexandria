import APIKit
import Foundation

public struct Library: Decodable {
    let address: String
    let pref: String
    let libid: String
    let systemid: String
    let systemName: String
    let category: String

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let address = dictionary["address"] as? String,
              let pref = dictionary["pref"] as? String,
              let libid = dictionary["libid"] as? String,
              let systemid = dictionary["systemid"] as? String,
              let systemName = dictionary["systemname"] as? String,
              let category = dictionary["category"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.address = address
        self.pref = pref
        self.libid = libid
        self.systemid = systemid
        self.systemName = systemName
        self.category = category
    }
}

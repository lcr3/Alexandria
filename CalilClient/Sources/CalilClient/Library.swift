import APIKit
import Foundation
import CloudKit
import SwiftUI

public struct Library: Decodable, Identifiable {
    public var id: String {
        return systemId
    }
    public let address: String
    public let pref: String
    public let libid: String
    public let systemId: String
    public let systemName: String
    public let category: String

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let address = dictionary["address"] as? String,
              let pref = dictionary["pref"] as? String,
              let libid = dictionary["libid"] as? String,
              let systemId = dictionary["systemid"] as? String,
              let systemName = dictionary["systemname"] as? String,
              let category = dictionary["category"] as? String else {
                  throw ResponseError.unexpectedObject(object)
              }
        self.address = address
        self.pref = pref
        self.libid = libid
        self.systemId = systemId
        self.systemName = systemName
        self.category = category
    }

    public init(address: String = "", pref: String = "", libid: String = "", systemId: String = "", systemName: String = "", category: String = "") {
        self.address = address
        self.pref = pref
        self.libid = libid
        self.systemId = systemId
        self.systemName = systemName
        self.category = category
    }
}

import APIKit
import SwiftUI

public struct Library: Decodable, Identifiable {
    public var id: String {
        systemId
    }

    public let name: String
    public let address: String
    public let pref: String
    public let city: String
    public let libid: String
    public let systemId: String
    public let systemName: String
    public let category: String
    public let latitude: Double
    public let longitude: Double

    public init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let name = dictionary["formal"] as? String,
              let address = dictionary["address"] as? String,
              let pref = dictionary["pref"] as? String,
              let city = dictionary["city"] as? String,
              let libid = dictionary["libid"] as? String,
              let systemId = dictionary["systemid"] as? String,
              let systemName = dictionary["systemname"] as? String,
              let category = dictionary["category"] as? String,
              let geocode = dictionary["geocode"] as? String
        else {
            throw ResponseError.unexpectedObject(object)
        }
        self.name = name
        self.address = address
        self.pref = pref
        self.city = city
        self.libid = libid
        self.systemId = systemId
        self.systemName = systemName
        self.category = category
        let location = geocode.components(separatedBy: ",")
        guard let longitude = Double(location[0]),
              let latitude = Double(location[1])
        else {
            throw ResponseError.unexpectedObject(object)
        }
        self.latitude = latitude
        self.longitude = longitude
    }

    public init(name: String = "",
                address: String = "",
                pref: String = "",
                city: String = "",
                libid: String = "",
                systemId: String = "",
                systemName: String = "",
                category: String = "",
                latitude: Double = 0,
                longitude: Double = 0)
    {
        self.name = name
        self.address = address
        self.pref = pref
        self.city = city
        self.libid = libid
        self.systemId = systemId
        self.systemName = systemName
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
    }
}

import CoreLocation

public protocol LocationClientProtocol {
    var output: LocationClientOutput? { get set }
    func requestLocation()
}

public protocol LocationClientOutput: AnyObject {
    func onLocationUpdated(_ location: CLLocation)
    func onError(_ error: Error)
}

public protocol LocationManagerProtocol {
    // CLLocationManager Properties
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    var distanceFilter: CLLocationDistance { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }

    // CLLocationManager Methods
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

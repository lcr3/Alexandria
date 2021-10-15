import CoreLocation
import Foundation

public class LocationClient: NSObject {
    public weak var output: LocationClientOutput?
    private var locationManager: LocationManagerProtocol?

    private override init() {
    }

    public convenience init(locationManager: LocationManagerProtocol = LocationManager()) {
        self.init()
        self.locationManager = locationManager
        self.locationManager?.delegate = self
    }

}

extension LocationClient: LocationClientProtocol {
    public func requestLocation() {
        locationManager?.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
}

extension LocationClient: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("[LocationClient] Delegate event didUpdateLocations: \(locations)")
        guard let location = locations.first else {
            output?.onError(LocationClientError.placemarkIsEmpty)
            return
        }
        locationManager?.stopUpdatingLocation()
        output?.onLocationUpdated(location)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationClient] Delegate event didFailWithError: \(error)")
        locationManager?.stopUpdatingLocation()
        output?.onError(error)
    }
}

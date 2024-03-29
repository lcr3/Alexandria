import CoreLocation
@testable import LocationClient

class TestMockLocationManager: LocationManagerProtocol {
    public init(location: CLLocation? = nil) {
        guard let location = location else {
            return
        }
        self.location = location
    }

    public var location: CLLocation?
    public var delegate: CLLocationManagerDelegate?
    public var distanceFilter: CLLocationDistance = 10
    public var pausesLocationUpdatesAutomatically = false
    public var allowsBackgroundLocationUpdates = true

    public var callCountRequestWhenInUseAuthorization = 0
    public var callCountStartUpdatingLocation = 0
    public var callCountStopUpdatingLocation = 0

    public func requestWhenInUseAuthorization() {
        callCountRequestWhenInUseAuthorization += 1
    }

    public func startUpdatingLocation() {
        guard let location = location else {
            delegate?.locationManager?(
                LocationManager(),
                didFailWithError: LocationClientError.placemarkIsEmpty
            )
            return
        }
        callCountStartUpdatingLocation += 1
        delegate?.locationManager?(
            LocationManager(),
            didUpdateLocations: [location]
        )
    }

    public func stopUpdatingLocation() {
        callCountStopUpdatingLocation += 1
    }
}

class TestMockLocationClientOutput: LocationClientOutput {
    public var callCountOnLocationUpdated = 0
    public var callCountOnError = 0
    public var location: CLLocation?
    public var error: Error?

    public func onLocationUpdated(_ location: CLLocation) {
        callCountOnLocationUpdated += 1
        self.location = location
    }

    public func onError(_ error: Error) {
        callCountOnError += 1
        self.error = error
    }
}

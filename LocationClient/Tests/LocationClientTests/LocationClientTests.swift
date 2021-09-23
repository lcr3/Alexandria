import CoreLocation
import XCTest
@testable import LocationClient

final class LocationClientTests: XCTestCase {
    var mockManager: MockLocationManager!
    var mockOutput: MockLocationClientOutput!
    var client: LocationClient!

    override func setUpWithError() throws {
        super.setUp()
        mockManager = MockLocationManager()
        mockOutput = MockLocationClientOutput()
        client = LocationClient(locationManager: mockManager)
        client.output = mockOutput
    }

    // requestでoutputが返ることをテスト
    func testLocationUpdate() throws {
        // setup
        let location = CLLocation(latitude: 33.0, longitude: 135.0)
        mockManager.location = location

        XCTAssertEqual(mockManager.callCountStartUpdatingLocation, 0)
        XCTAssertEqual(mockManager.callCountStopUpdatingLocation, 0)
        XCTAssertEqual(mockOutput.callCountOnLocationUpdated, 0)
        XCTAssertEqual(mockOutput.callCountOnError, 0)
        XCTAssertEqual(mockOutput.location, nil)

        // execute
        client.requestLocation()

        // verify
        XCTAssertEqual(mockManager.callCountStartUpdatingLocation, 1)
        XCTAssertEqual(mockManager.callCountStopUpdatingLocation, 1)
        XCTAssertEqual(mockOutput.callCountOnLocationUpdated, 1)
        XCTAssertEqual(mockOutput.callCountOnError, 0)
        XCTAssertEqual(mockOutput.location, location)
    }

    func testLocationUpdateError() throws {
        // setup
        XCTAssertEqual(mockManager.callCountStartUpdatingLocation, 0)
        XCTAssertEqual(mockManager.callCountStopUpdatingLocation, 0)
        XCTAssertEqual(mockOutput.callCountOnLocationUpdated, 0)
        XCTAssertEqual(mockOutput.callCountOnError, 0)

        // execute
        client.requestLocation()

        // verify
        XCTAssertEqual(mockManager.callCountStartUpdatingLocation, 0)
        XCTAssertEqual(mockManager.callCountStopUpdatingLocation, 1)
        XCTAssertEqual(mockOutput.callCountOnLocationUpdated, 0)
        XCTAssertEqual(mockOutput.callCountOnError, 1)
    }
}


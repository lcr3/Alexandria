import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {
    
}

struct SelectAddressView: View, SelectAddressViewProtocol {
    @ObservedObject private var presenter: SelectAddressPresenter
    private let dependencies: SelectAddressViewDependenciesProtocol
//    @State private var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
//            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//            )
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        ZStack {
            Map(coordinateRegion: $presenter.region, showsUserLocation: true, userTrackingMode: $userTrackingMode)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    LocationButton(.currentLocation) {
                        presenter.locationButtonTapped()
                    }.frame(width: 44, height: 44)
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .cornerRadius(22)
                        .tint(Color("Main"))
                        .foregroundColor(.white)
                }
            }.padding()
        }
    }
    
    init(presenter: SelectAddressPresenter,
         dependencies: SelectAddressViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressWireFrame.makeSelectAddressView()
    }
}

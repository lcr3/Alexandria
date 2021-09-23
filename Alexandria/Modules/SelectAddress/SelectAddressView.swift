import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {
    
}

struct SelectAddressView: View, SelectAddressViewProtocol {
    @ObservedObject private var presenter: SelectAddressPresenter
    private let dependencies: SelectAddressViewDependenciesProtocol

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $presenter.region,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode
            )
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
        }.edgesIgnoringSafeArea(.all)
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

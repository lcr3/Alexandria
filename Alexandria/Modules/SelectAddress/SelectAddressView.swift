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
                    Button("OK") {
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .tint(.main)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .foregroundColor(.main)
                            .shadow(
                                color: Color.black.opacity(0.8),
                                radius: 12,
                                x: 6,
                                y: 8
                            )
                    )
                    Spacer()
                    LocationButton(.currentLocation) {
                        presenter.locationButtonTapped()
                    }
                    .frame(width: 44, height: 44)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .cornerRadius(22)
                    .tint(.main)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .foregroundColor(.main)
                            .shadow(
                                color: Color.black.opacity(0.8),
                                radius: 12,
                                x: 6,
                                y: 8
                            )
                    )
                }
            }.padding()
            VStack {
                LibraryListView(
                    items: $presenter.nearLibraries
                ).padding(.top, 80)
                Spacer()
            }
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

import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {
}

struct SelectAddressView: View, SelectAddressViewProtocol {
    @ObservedObject private var presenter: SelectAddressPresenter
    private let dependencies: SelectAddressViewDependenciesProtocol

    var body: some View {
        VStack {
            Map(
                coordinateRegion: $presenter.region,
                showsUserLocation: true,
                userTrackingMode: $presenter.userTrackingMode,
                annotationItems: presenter.libraryAnnotations) { item in
                MapMarker(coordinate: item.coordinate, tint: .red)
            }.overlay(
                LocationButton(.currentLocation) {
                presenter.locationButtonTapped()
            }
                    .frame(width: 44, height: 44)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .cornerRadius(22)
                    .tint(.blue)
                    .foregroundColor(.white)
                    .padding(),
                alignment: .bottomTrailing
            )
                .cornerRadius(40)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("OK") {
                        presenter.okButtonTapped()
                    }
                    .frame(minWidth: 0.0, maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(22)
                    .disabled(presenter.nearLibraries.isEmpty)
                    Spacer()
                }
            }.padding(.bottom, 16)

            //            .padding()
            //            VStack {
            //                LibraryListView(
            //                    items: $presenter.nearLibraries
            //                ).padding(.top, 80)
            //                Spacer()
            //            }
        }.padding()
    }
    init(presenter: SelectAddressPresenter,
         dependencies: SelectAddressViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct SelectAdressView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressWireFrame.makeSelectAddressView(isPresented: .constant(false),
        calilClient: MockCalilClient(),
        locationClient: MockLocationClient())
    }
}

import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {
}

struct SelectAddressView: View, SelectAddressViewProtocol {
    @ObservedObject private var presenter: SelectAddressPresenter
    private let dependencies: SelectAddressViewDependenciesProtocol

    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $presenter.region,
                showsUserLocation: true,
                userTrackingMode: $presenter.userTrackingMode,
                annotationItems: presenter.libraryAnnotations) { item in
                    MapMarker(coordinate: item.coordinate, tint: .red)
            }

            VStack {
                Spacer()
                HStack {
                    Button {
                        presenter.okButtonTapped()
                    } label: {
                        Text("OK")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .tint(.main)
                            .foregroundColor(.white)

                    }
                    .disabled(presenter.nearLibraries.isEmpty)

                }
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
            }.padding(.bottom, 16)

            //            .padding()
            //            VStack {
            //                LibraryListView(
            //                    items: $presenter.nearLibraries
            //                ).padding(.top, 80)
            //                Spacer()
            //            }
        }.edgesIgnoringSafeArea(.all)
    }

    init(presenter: SelectAddressPresenter,
         dependencies: SelectAddressViewDependenciesProtocol) {
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

struct SelectAdressView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressWireFrame.makeSelectAddressView(isPresented: .constant(false))
    }
}

struct ShadowView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .foregroundColor(.main)
            .shadow(
                color: Color.black.opacity(0.8),
                radius: 12,
                x: 6,
                y: 8
            )
    }
}

import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {}

struct SelectAddressView: View, SelectAddressViewProtocol {
    @ObservedObject private var presenter: SelectAddressPresenter

    var body: some View {
        VStack {
            VStack {
                List {
                    Section {
                        Map(
                            coordinateRegion: $presenter.region,
                            showsUserLocation: true,
                            userTrackingMode: $presenter.userTrackingMode,
                            annotationItems: presenter.libraryAnnotations
                        ) { item in
                            MapMarker(coordinate: item.coordinate, tint: .red)
                        }
                        .frame(height: 300)
                        .onTapGesture {}
                    }
                    Section(header: Text(L10n.selectAddressSectionTitle)) {
                        ForEach(presenter.nearLibraries) { library in
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                VStack {
                                    Text(library.name)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                HStack {
                    Button(L10n.adderssConfirmButtonTitle) {
                        presenter.okButtonTapped()
                    }
                    .frame(minWidth: 0.0, maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundColor(.white)
                    .background(presenter.nearLibraries.isEmpty ? .gray : .blue)
                    .cornerRadius(14)
                    .disabled(presenter.nearLibraries.isEmpty)

                    Spacer()
                    LocationButton(.currentLocation) {
                        presenter.locationButtonTapped()
                    }
                    .cornerRadius(22)
                    .frame(width: 44, height: 44)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .tint(.blue)
                    .foregroundColor(.white)
                }.padding()
            }

            .padding(.bottom, 16)
        }
        .background(Color.listBackground)
        .onAppear {
            presenter.checkHaveStarted()
        }
        .alert(item: $presenter.error) {
            Alert(
                title: Text(L10n.errorAlertTitle),
                message: Text($0.description),
                dismissButton: .default(Text(L10n.okButtonTitle))
            )
        }
        .alert(isPresented: $presenter.isHaveStarted) {
            Alert(
                title: Text(L10n.errorAlertTitle),
                message: Text(L10n.adderessAlertMessage),
                dismissButton: .default(Text(L10n.okButtonTitle)) {
                    presenter.firstAlertOkButtonTapped()
                }
            )
        }
    }

    init(presenter: SelectAddressPresenter) {
        self.presenter = presenter
    }
}

// struct SelectAdressView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectAddressWireFrame.makeSelectAddressView(isPresented: .constant(false),
//                                                     calilClient: PreviewCalilClient(),
//                                                     locationClient: MockLocationClient())
//    }
// }

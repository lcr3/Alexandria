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
            VStack {
                List {
                    Section {
                        Map(
                            coordinateRegion: $presenter.region,
                            showsUserLocation: true,
                            userTrackingMode: $presenter.userTrackingMode,
                            annotationItems: presenter.libraryAnnotations) { item in
                            MapMarker(coordinate: item.coordinate, tint: .red)
                        }.frame(height: 300)
                    }
                        Section(header: Text("近隣の図書館検索結果")) {
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
                    Button("対象図書館を確定する") {
                        presenter.okButtonTapped()
                    }
                    .frame(minWidth: 0.0, maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundColor(.white)
                    .background(presenter.nearLibraries.isEmpty ? .gray: .blue)
                    .cornerRadius(14)
                    .disabled(presenter.nearLibraries.isEmpty)

                    Spacer()
                    LocationButton(.currentLocation) {
                    presenter.locationButtonTapped()
                    }
                    .frame(width: 44, height: 44)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .cornerRadius(22)
                    .tint(.blue)
                    .foregroundColor(.white)
                    .padding()
                }.padding()
            }.padding(.bottom, 16)
        }.background(Color.listBackground)

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

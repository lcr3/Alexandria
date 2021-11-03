import CoreLocationUI
import MapKit
import SwiftUI

protocol SelectAddressViewProtocol {
}

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
                    .cornerRadius(22)
                    .frame(width: 44, height: 44)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                    .tint(.blue)
                    .foregroundColor(.white)
                }.padding()
            }.padding(.bottom, 16)
        }
        .background(Color.listBackground)
        .alert("", isPresented: $presenter.isHaveStarted, actions: {
            Button("OK") {
                presenter.firstAlertOkButtonTapped()
            }
        }, message: {
            Text("位置情報をオンにして現在地から近い図書館を検索します。")
        })
        .onAppear {
            presenter.checkHaveStarted()
        }
    }
    init(presenter: SelectAddressPresenter) {
        self.presenter = presenter
    }
}

struct SelectAdressView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressWireFrame.makeSelectAddressView(isPresented: .constant(false),
        calilClient: PreviewCalilClient(),
        locationClient: MockLocationClient())
    }
}

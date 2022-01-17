import StorageClient
import SwiftUI

protocol SettingWireFrameProtocol {
    static func makeSettingView(storegeClient: StorageClientProtocol) -> AnyView
}

struct SettingWireFrame: SettingWireFrameProtocol {
    static func makeSettingView(storegeClient: StorageClientProtocol) -> AnyView {
        let interactorDependencies = SettingInteractorDependencies(storegeClient: storegeClient)
        let interactor = SettingInteractor(dependencies: interactorDependencies)
        let presenter = SettingPresenter(interactor: interactor)
        interactor.output = presenter
        let view = SettingView(presenter: presenter)
        return AnyView(view)
    }
}

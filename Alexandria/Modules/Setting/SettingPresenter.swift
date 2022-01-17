import CalilClient
import SwiftUI

protocol SettingPresenterProtocol {
    var savedLibraries: [Library] { get set }
    var error: SettingError? { get set }
}

final class SettingPresenter: ObservableObject {
    @Published var savedLibraries: [Library]
    @Published var error: SettingError?

    private let interactor: SettingInteractorProtocol

    init(interactor: SettingInteractorProtocol) {
        self.interactor = interactor
        savedLibraries = []
        interactor.getSaveLibraries()
    }
}

extension SettingPresenter: SettingPresenterProtocol {}

extension SettingPresenter: SettingInteractorOutput {
    func successGet(libraries: [Library]) {
        savedLibraries = libraries
    }

    func failureGet(_ error: SettingError) {
        self.error = error
    }
}

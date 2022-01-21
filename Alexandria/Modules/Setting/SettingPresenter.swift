import CalilClient
import SwiftUI

protocol SettingPresenterProtocol {
    var savedLibraries: [Library] { get set }
    var error: SettingError? { get set }

    func getSaveLibraries()
    func resetButtonTouched()
}

final class SettingPresenter: SettingPresenterProtocol, ObservableObject {
    @Published var savedLibraries: [Library]
    @Published var error: SettingError?

    private let interactor: SettingInteractorProtocol

    init(interactor: SettingInteractorProtocol) {
        self.interactor = interactor
        savedLibraries = []
    }

    func getSaveLibraries() {
        interactor.getSaveLibraries()
    }

    func resetButtonTouched() {
        print("reset")
    }
}

extension SettingPresenter: SettingInteractorOutput {
    func successGet(libraries: [Library]) {
        self.savedLibraries = libraries
    }

    func failureGet(_ error: SettingError) {
        self.error = error
    }
}

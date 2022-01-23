import CalilClient
import SwiftUI

protocol SettingPresenterProtocol {
    var savedLibraries: [Library] { get set }
    var isShowDeleteLocationAlert: Bool { get set }
    var error: SettingError? { get set }

    func getSaveLibraries()
    func resetButtonTouched()
    func locationDeleteAlertButtonTapped()
}

final class SettingPresenter: SettingPresenterProtocol, ObservableObject {
    @Published var savedLibraries: [Library]
    @Published var isShowDeleteLocationAlert: Bool
    @Published var error: SettingError?

    private let interactor: SettingInteractorProtocol

    init(interactor: SettingInteractorProtocol) {
        self.interactor = interactor
        savedLibraries = []
        isShowDeleteLocationAlert = false
    }

    func getSaveLibraries() {
        interactor.getSaveLibraries()
    }

    func resetButtonTouched() {
        isShowDeleteLocationAlert = true
    }

    func locationDeleteAlertButtonTapped() {
        isShowDeleteLocationAlert = false
        // delete
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

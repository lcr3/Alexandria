//
//  SettingMocks.swift
//  AlexandriaTests
//
//  Created by lcr on 2022/01/25.
//

import CalilClient
@testable import Alexandria

final class MockSettingInteractor {
    init() {}
    var output: SettingInteractorOutput?
    var mockLibraries: [Library] = []
}

extension MockSettingInteractor: SettingInteractorProtocol {
    func getSaveLibraries() {
        output?.successGet(libraries: mockLibraries)
    }

    func deleteSaveLibraries() {

    }
}

final class MockSettingPresenter {
    var savedLibraries: [Library] = []
    var isShowDeleteLocationAlert = false
    var error: SettingError?
    init() {}
}

extension MockSettingPresenter: SettingPresenterProtocol {
    func getSaveLibraries() {
    }

    func resetButtonTouched() {

    }

    func locationDeleteAlertButtonTapped() {

    }
}

extension MockSettingPresenter: SettingInteractorOutput {
    func successGet(libraries: [Library]) {
        savedLibraries
    }

    func failureGet(_: SettingError) {
        error
    }
}

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
    var mockError: SettingInteractorError?
    var mockLibraries: [Library] = []
}

extension MockSettingInteractor: SettingInteractorProtocol {
    func getSaveLibraries() {
        if let error = mockError {
            output?.failureGet(error)
            return
        }
        output?.successGet(libraries: mockLibraries)
    }

    func deleteSaveLibraries() {

    }
}

final class MockSettingPresenter {
    var savedLibraries: [Library] = []
    var isShowDeleteLocationAlert = false
    var error: SettingInteractorError?
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
        savedLibraries = libraries
    }

    func failureGet(_ error: SettingInteractorError) {
        self.error = error
    }
}

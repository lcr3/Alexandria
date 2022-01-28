import CalilClient
import Foundation

protocol SettingInteractorOutput: AnyObject {
    func successGet(libraries: [Library])
    func failureGet(_: SettingInteractorError)
}

enum SettingInteractorError: Error {
    case unknow
    case failedDecode
}

extension SettingInteractorError: Identifiable {
    var id: Self { self }
}


protocol SettingInteractorProtocol {
    var output: SettingInteractorOutput? { get set }
    func getSaveLibraries()
    func deleteSaveLibraries()
}

final class SettingInteractor {
    private var dependencies: SettingInteractorDependenciesProtocol
    weak var output: SettingInteractorOutput?

    init(dependencies: SettingInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension SettingInteractor: SettingInteractorProtocol {
    func getSaveLibraries() {
        let datas = dependencies.storegeClient.libraries
        var libraries: [Library] = []

        for data in datas {
            do {
                let library = try JSONDecoder().decode(Library.self, from: data)
                libraries.append(library)
            } catch {
                self.output?.failureGet(.failedDecode)
                break
            }
        }
        self.output?.successGet(libraries: libraries)
    }

    func deleteSaveLibraries() {
        dependencies.storegeClient.resetLibraries()
    }
}

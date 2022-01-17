import CalilClient
import Foundation

protocol SettingInteractorOutput: AnyObject {
    func successGet(libraries: [Library])
    func failureGet(_: SettingError)
}

struct SettingError: Error, Identifiable {
    var id = UUID()
}

protocol SettingInteractorProtocol {
    var output: SettingInteractorOutput? { get set }
    func getSaveLibraries()
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
                output?.failureGet(SettingError())
                break
            }
        }
    }
}

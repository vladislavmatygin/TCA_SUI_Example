import Foundation
import ComposableArchitecture

@Reducer
struct ProfileStore {
    @ObservableState
    struct State {
        var name = ""

        @Presents var profileSettings: ProfileSettingsStore.State?
        @Presents var changeName: ChangeNameStore.State?
    }

    enum Action {
        case showSettings(String)
        case showChangeName(String)
        case changeNameAction(PresentationAction<ChangeNameStore.Action>)
        case settingsAction(PresentationAction<ProfileSettingsStore.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showSettings(let settings):
                state.profileSettings = ProfileSettingsStore.State(settings: settings)
                return .none
            case .showChangeName(let name):
                state.changeName = ChangeNameStore.State(name: name)
                return .none
            case .settingsAction(.presented(.close)):
                state.profileSettings = nil
                print("Закрыли за счёт заниления значения в родительском экране")
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$profileSettings, action: \.settingsAction) {
            ProfileSettingsStore()
        }
        .ifLet(\.$changeName, action: \.changeNameAction) {
            ChangeNameStore()
        }
    }
}

import Foundation
import ComposableArchitecture

@Reducer
struct ProfileSettingsStore {
    @ObservableState
    struct State {
        var settings = ""
    }

    enum Action {
        case save
        case close
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

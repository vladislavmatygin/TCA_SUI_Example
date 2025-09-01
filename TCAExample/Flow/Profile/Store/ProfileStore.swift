import Foundation
import ComposableArchitecture

@Reducer
struct ProfileStore {
    @ObservableState
    struct State {
        var name = ""
    }

    enum Action {
        case doIt
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

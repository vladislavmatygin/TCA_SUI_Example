import Foundation
import ComposableArchitecture

@Reducer
struct SearchDetailStore {
    @ObservableState
    struct State {
        var name = ""
        var image = ""
    }

    enum Action {
        case close
        case rootClose
        case openEdit
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .close:
                return .run { _ in
                    await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}

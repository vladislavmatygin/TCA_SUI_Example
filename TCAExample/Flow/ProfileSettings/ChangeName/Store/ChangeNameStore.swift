import Foundation
import ComposableArchitecture

@Reducer
struct ChangeNameStore {
    @ObservableState
    struct State {
        var name: String
    }

    enum Action {
        case save
        case close
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .close:
                return .run { _ in
                    print("Закрытие экрана(дочернего) с помощью @Dependency внутри себя")
                    await self.dismiss()
                }
            default:
                return .none
            }
        }
    }
}

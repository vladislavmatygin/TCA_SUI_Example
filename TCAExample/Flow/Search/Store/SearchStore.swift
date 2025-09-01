import Foundation
import ComposableArchitecture

@Reducer
struct SearchStore {
    @ObservableState
    struct State {
        var isLoading = false
        var loadedCharacters: [ModelCharacter] = []
        var stack = StackState<Path.State>()
    }

    enum Action {
        case loadedCharacters
        case setResults([ModelCharacter])
        case stackAction(StackActionOf<Path>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadedCharacters:
                state.isLoading = true
                return .run { send in
                    let result = try? await CharactersAPI.getAllCharacters(page: 1)
                    let newCharacters = result?.results ?? []
                    await send(.setResults(newCharacters))
                }
            case .setResults(let newCharacters):
                state.isLoading = false
                state.loadedCharacters = newCharacters
                return .none
            case let .stackAction(.element(id: id, action: .detail(.rootClose))):
                state.stack.pop(from: id)
                return .none
//            case .stackAction(.element(id: _, action: .detail(.openEdit))):
//                state.stack.append(Path.State.edit(StackEditPersonStack.State()))
//                return .none
            default:
                return .none
            }
        }
        .forEach(\.stack, action: \.stackAction)
    }
}

extension SearchStore {

    @Reducer
    enum Path {
        case detail(SearchDetailStore)
    }
}

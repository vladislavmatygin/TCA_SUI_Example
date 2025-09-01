import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @Bindable var store: StoreOf<SearchStore>

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.stack, action: \.stackAction)
        ) {
            List {
                ForEach(store.loadedCharacters, id: \.id) { currentChar in
                    NavigationLink(
                        state: SearchStore.Path.State.detail(
                            SearchDetailStore.State(name: currentChar.name, image: currentChar.image ?? "")
                        ), label: {
                            Text(currentChar.name)
                        })
                }
            }
        } destination: { store in
            switch store.case {
            case .detail(let detailStore):
                SearchDetailView(store: detailStore)
                    .navigationBarBackButtonHidden()
            }
        }
        .onAppear {
            store.send(.loadedCharacters)
        }
    }
}

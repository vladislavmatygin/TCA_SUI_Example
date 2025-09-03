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
                            HStack(spacing: 30) {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35)

                                Text(currentChar.name)
                            }
                            .padding()
                        })
                }
            }
        } destination: { store in
            switch store.case {
            case .detail(let detailStore):
                SearchDetailView(store: detailStore)
                    .navigationBarBackButtonHidden()
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .onAppear {
            store.send(.loadedCharacters)
        }
        .task {
            await store.send(.loadedCharacters).finish()
        }
    }
}

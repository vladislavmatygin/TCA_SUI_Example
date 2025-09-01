import SwiftUI
import ComposableArchitecture

struct TabBar: View {
    var body: some View {
        if #available(iOS 18, *) {
            TabView {
                Tab("Search", systemImage: "text.page.badge.magnifyingglass") {
                    SearchView(store: Store(initialState: SearchStore.State(), reducer: { SearchStore() }))
                }

                Tab("Profile", systemImage: "person.circle") {
                    ProfileView(store: Store(initialState: ProfileStore.State(), reducer: { ProfileStore() }))
                }
            }
        } else {
            TabView {
                SearchView(store: Store(initialState: SearchStore.State(), reducer: { SearchStore() }))
                    .tabItem {
                        Label("Search", systemImage: "text.page.badge.magnifyingglass")
                    }

                ProfileView(store: Store(initialState: ProfileStore.State(), reducer: { ProfileStore() }))
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        }
    }
}

#Preview {
    TabBar()
}

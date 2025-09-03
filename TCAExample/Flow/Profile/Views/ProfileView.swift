import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    @State private var email: String = ""

    @Bindable var store: StoreOf<ProfileStore>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 75, height: 75)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("John Doe")
                            .font(.headline)
                        Text("johndoe@example.com")
                            .font(.caption)
                    }
                    Spacer()
                }

                Text("Some info about the user")
            }
            .padding(.horizontal, 20)


            VStack(alignment: .leading) {
                Text("Actions:")
                    .font(.headline)

                HStack() {
                    Button {
                        store.send(.showSettings("settings"))
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.background)
                                .frame(width: 30, height: 30)

                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                    .buttonStyle(.bordered)


                    Button("Change Name") {
                        store.send(.showChangeName("Vlad"))
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .fullScreenCover(item: $store.scope(
            state: \.changeName,
            action: \.changeNameAction
        )) { store in
            ChangeNameView(store: store)
        }
        .fullScreenCover(item: $store.scope(
            state: \.profileSettings,
            action: \.settingsAction
        )) { store in
            ProfileSettingsView(store: store)
        }
    }
}

#Preview {
    ProfileView(store: Store(initialState: ProfileStore.State(), reducer: { ProfileStore() }))
}

import SwiftUI
import ComposableArchitecture

struct ProfileSettingsView: View {
    var store: StoreOf<ProfileSettingsStore>

    var body: some View {
        Text("ProfileSettingsView")

        Button("Close") {
            store.send(.close)
        }
    }
}

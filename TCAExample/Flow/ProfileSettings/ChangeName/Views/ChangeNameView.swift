import SwiftUI
import ComposableArchitecture

struct ChangeNameView: View {
    var store: StoreOf<ChangeNameStore>

    var body: some View {
        Text("ChangeNameView")

        Button("Close") {
            store.send(.close)
        }
    }
}

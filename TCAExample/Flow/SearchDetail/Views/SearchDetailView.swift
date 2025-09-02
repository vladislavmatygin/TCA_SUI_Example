import SwiftUI
import ComposableArchitecture

struct SearchDetailView: View {
    var store: StoreOf<SearchDetailStore>

    var body: some View {
        Text("Search Detail View")

        VStack {
            VStack {
                Text(store.name)
                AsyncImage(url: URL(string: store.image)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.green
                }

                Button("Close") {
                    store.send(.close)
                }

                Button("Root Close") {
                    store.send(.rootClose)
                }

                Button("Open Edit") {
                    store.send(.openEdit)
                }
            }
        }
    }
}

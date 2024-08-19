import SwiftUI

struct WidgetScreenView: View {
    let userid: String

    var body: some View {
        NavigationView {
            WidgetView(userid: userid)
                .navigationTitle("All Tasks")
        }
    }
}

#Preview {
    WidgetScreenView(userid: "iNuMaZ06z6ThioA5jjwXAsXMPiZ2")
}

import SwiftUI

struct mainhomeview: View {
    @State private var newItemAdd: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                //Color.black.edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 220)
                    .edgesIgnoringSafeArea(.all)

            
                    VStack {
                       HorizontalScroll(userid: "iNuMaZ06z6ThioA5jjwXAsXMPiZ2") // Replace with actual user ID
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            newItemAdd = true // Show the timePickerview sheet
                        }) {
                            Image(systemName: "plus")
                                
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Wave")
                            .font(.custom("GreatVibes-Regular", size: 80))
                            
                            .offset(y: 25)
                    }
                }
            }
        
        .sheet(isPresented: $newItemAdd) {
            timePickerview(newItemAdd: $newItemAdd)
        }
    }
}

#Preview {
    mainhomeview()
}

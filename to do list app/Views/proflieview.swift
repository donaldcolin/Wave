import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var rewardPoints = 0
    @State private var progressPoints = 100 // Points to next level
    @State private var rotation: Double = 0
    @State private var isAnimating = false
    @StateObject var viewmodel = profileViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            VStack {
                Text("Donald colin")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Button(action: {
                    viewmodel.logout()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            // Circular progress indicator
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.white.opacity(0.3))
                    .rotationEffect(.degrees(270))
                    .frame(width: 200, height: 200)
                
                Text("\(rewardPoints)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                
                Text("points")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.7))
                    .offset(y: 35)
            }

            Text("\(progressPoints) points to next level")
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()

            Button(action: {
                completeTask()
            }) {
                Text("GET A REWARD")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            Spacer()
            

            // Username and Sign out button
            
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color.green.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
        )
        .ignoresSafeArea()
    }

    func completeTask() {
        // Function to update points when a task is completed
        rewardPoints += 1
        progressPoints -= 1 // Assuming the progress points decrease as you get closer to the next level
        
        // You can add additional logic here if needed, such as checking if progressPoints reach zero
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

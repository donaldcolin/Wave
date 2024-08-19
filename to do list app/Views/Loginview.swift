import SwiftUI

struct Loginview: View {
    @StateObject var viewmodel = LoginViewModel()
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black.edgesIgnoringSafeArea(.all)
                
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 500)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Pulse")
                        .font(Font.custom("GreatVibes-Regular", size: 150))
                        .foregroundStyle(.white)
                    
                    Text("A Minimalist To-Do List")
                        .font(.system(size: 20))
                        .font(.subheadline)
                        .foregroundStyle(.white)
           
                    VStack {
                        Spacer()
                        TextField("    Enter Username", text: $viewmodel.email)
                            .autocapitalization(.none)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            )
                        
                        SecureField("    Enter Password", text: $viewmodel.pass)
                            .padding(.horizontal)
                            
                            .frame(height: 50)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            )
                        if !viewmodel.errormessage.isEmpty {
                            Text(viewmodel.errormessage)
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        Button {
                            viewmodel.login()
                        } label: {
                            Text("Log In")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: 340, height: 44)
                                .background(Color(.systemBlue))
                                .cornerRadius(10)
                        }
                        
                    }.offset(y:-20)
                    
                    Spacer()
                    
                    NavigationLink {
                        Registerview_()
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    Loginview()
}

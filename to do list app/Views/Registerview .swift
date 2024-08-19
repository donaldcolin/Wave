import SwiftUI

struct Registerview_: View {
    @StateObject var viewmodel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black.edgesIgnoringSafeArea(.all)
                
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 400)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("pulse")
                        .font(Font.custom("GreatVibes-Regular", size: 150))
                        .font(.system(size: 150))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("A Minimalist To-Do List")
                        .font(.system(size: 20))
                        .font(.caption)
                        .foregroundStyle(.white)
                    
               
                    
                    VStack {
                        Spacer()
                        TextField("Enter name", text: $viewmodel.name)
                                        .padding(.horizontal)
                                        .frame(height: 60)
                                        .foregroundColor(.white)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                                        )
                                        .padding(.bottom, 10)
                        
                        TextField("    Enter Username", text: $viewmodel.email)
                            .autocapitalization(.none)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            )
                            .padding(.bottom, 10)
                        
                        SecureField("    Enter Password", text: $viewmodel.password)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .foregroundStyle(.white)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            ).padding(.bottom, 10)
                           
                        if !viewmodel.errorMessage.isEmpty {
                            Text(viewmodel.errorMessage)
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                            
                      
                        
                          
               
                        Spacer()
                    }
                    
                }
                VStack{
                    Spacer()
                    Button {
                        viewmodel.createAccount()
                    } label: {
                        Text("Create Account")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(width: 340, height: 44)
                            .background(Color(.green))
                            .cornerRadius(10)
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    Registerview_()
}

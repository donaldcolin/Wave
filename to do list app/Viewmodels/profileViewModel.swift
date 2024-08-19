//
//  profileViewModel.swift
//  to do list app
//
//  Created by Donald Colin on 19/08/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class profileViewModel: ObservableObject{
    init() {}
    
    
    @Published var user :User? = nil
    
    func fetchUser(){
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument{[weak self] snapshot , error in
            guard let data = snapshot?.data(),error == nil else {return}
            
            DispatchQueue.main.async {
                self?.user = User(id: data["id"] as? String ?? "",
                                 name: data["name"] as? String ?? "",
                                 email: data["email"] as? String ?? "")
            }
            
        }
    }
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch{print("error")}
        
    }
    
}


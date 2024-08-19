//
//  LoginViewModel.swift
//  to do list app
//
//  Created by Donald Colin on 13/08/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var pass = ""
    @Published var errormessage = ""
    
    func login() {
        // First, validate the input
        guard validate() else { return }
        
        // Perform the login logic
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            if let error = error {
                // If login fails, set the error message accordingly
                self?.errormessage = error.localizedDescription
            } else {
                // Login successful, clear error message
                self?.errormessage = ""
            }
        }
    }
    
    func validate() -> Bool {
        // Check if the email and password fields are empty
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           pass.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errormessage = "Please enter both email and password."
            return false
        } else if !isValidEmail(email) { // Check if the email is valid
            errormessage = "Please enter a valid email address."
            return false
        }
        
        // Clear the error message if validation passes
        errormessage = ""
        return true
    }
    
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        // Define a regular expression for valid email addresses
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // Create a predicate to evaluate the email against the regular expression
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        // Return true if the email matches the regular expression, otherwise false
        return emailPred.evaluate(with: email)
    }
}



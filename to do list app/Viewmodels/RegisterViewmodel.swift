import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    func createAccount() {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Failed to create user: \(error.localizedDescription)"
                return
            }
            
            guard let userId = result?.user.uid else {
                self?.errorMessage = "Failed to retrieve user ID."
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email)

        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary() ?? [:]) { [weak self] error in
                if let error = error {
                    self?.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                }
            }
    }

    func validate() -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter your name, email, and password."
            return false
        } else if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address."
            return false
        }
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

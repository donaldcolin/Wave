import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class TimePickerViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate: Date = Date()
    @Published var fortoday: Bool = false
    
    init() {}
    
    func save() {
        guard isValidTask else {
            print("Task name is invalid.")
            return
        }
        
        guard isValidDate else {
            print("Due date is invalid.")
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            return
        }

        // Create model
        let newId = UUID().uuidString
        let newItem = Todoitem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )

        // Save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("Todos")
            .document(newId) // Use UUID for unique document ID
            .setData(newItem.asDictionary()) { error in
                if let error = error {
                    print("Error saving task: \(error.localizedDescription)")
                } else {
                    print("Task saved successfully.")
                }
            }
    }
    
    // Validation checks
    var isValidTask: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var isValidDate: Bool {
        fortoday || dueDate > Date()
    }
}


import SwiftUI
import FirebaseFirestore


struct newItemsView: View {
    @StateObject var viewmodel = TimePickerViewModel()

    @FirestoreQuery var firestoreItems: [Todoitem]

    @State private var items: [Todoitem] = []
    @State private var showUndoPopUp = false
    @State private var deletedItem: Todoitem?
    @State private var deletedItemIndex: Int?
    private let userid: String
    private let filter: Tabs

    init(userid: String, filter: Tabs) {
        self.userid = userid
        self.filter = filter
        self._firestoreItems = FirestoreQuery(
            collectionPath: "users/\(userid)/Todos"
        )
    }

    var body: some View {
        VStack {
            if filteredItems.isEmpty {
                Text("No tasks available")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(filteredItems.indices, id: \.self) { index in
                        SingleItemView(item: filteredItems[index])
                           
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deleteItem(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(PlainListStyle())
            }

            if showUndoPopUp {
                HStack {
                    Text("Item deleted")
                    Spacer()
                    Button("Undo") {
                        undoDelete()
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.9))
                .cornerRadius(10)
                .transition(.move(edge: .bottom))
                .zIndex(1)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        hideUndoPopUp()
                    }
                }
            }
        }

        .onAppear {
            items = firestoreItems
        }
        .onChange(of: firestoreItems) { newItems in
            items = newItems
        }
        .animation(.easeInOut)
    }

    private var filteredItems: [Todoitem] {
        let today = Calendar.current.startOfDay(for: Date())
        switch filter {
        case .today:
            return items.filter { Calendar.current.isDateInToday(Date(timeIntervalSince1970: $0.dueDate)) }
        case .all:
            return items
        case .overtime:
            return items.filter { Date(timeIntervalSince1970: $0.dueDate) < today && !$0.isDone }
        }
    }

    private func deleteItem(at index: Int) {
        deletedItem = items[index]
        deletedItemIndex = index
        let itemToDelete = items[index]

        items.remove(at: index)
        showUndoPopUp = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            if !showUndoPopUp {
                deleteItemFromFirestore(item: itemToDelete)
            }
        }
    }

    private func deleteItemFromFirestore(item: Todoitem) {
        let db = Firestore.firestore()
        db.collection("users/\(userid)/Todos").document(item.id).delete { error in
            if let error = error {
                print("Error deleting item: \(error.localizedDescription)")
            } else {
                print("Item deleted successfully.")
            }
        }
    }

    private func undoDelete() {
        if let item = deletedItem, let index = deletedItemIndex {
            items.insert(item, at: index)
        }
        hideUndoPopUp()
    }

    private func hideUndoPopUp() {
        showUndoPopUp = false
        deletedItem = nil
        deletedItemIndex = nil
    }
}

#Preview {
    newItemsView(userid: "iNuMaZ06z6ThioA5jjwXAsXMPiZ2", filter: .all)
} 

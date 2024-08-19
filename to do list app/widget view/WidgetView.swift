//
//  WidgetView.swift
//  to do list app
//
//  Created by Donald Colin on 19/08/24.

import SwiftUI
import FirebaseFirestore

struct WidgetView: View {
    @FirestoreQuery var firestoreItems: [Todoitem]
    
    @State private var items: [Todoitem] = []
    private let userid: String
    
    init(userid: String) {
        self.userid = userid
        self._firestoreItems = FirestoreQuery(
            collectionPath: "users/\(userid)/Todos"
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Tasks")
                .font(.headline)
                .padding(.top)
                .padding(.leading)
            
            if items.isEmpty {
                Text("No tasks available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(items, id: \.id) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.body)
                                    Text(dueDateString(for: item.dueDate))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if item.isDone {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            items = firestoreItems
        }
        .onChange(of: firestoreItems) { newItems in
            items = newItems
        }
    }
    
    private func dueDateString(for timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    WidgetView(userid: "iNuMaZ06z6ThioA5jjwXAsXMPiZ2")
}

import SwiftUI

struct SingleItemView: View {
    let item: Todoitem

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                // Handle task completion toggle
            } label: {
                Image(systemName: item.isDone ? "circle.checkmark.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isDone ? .green : .gray)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(radius: 1, x: 0, y: 1)
    }
}

#Preview {
    SingleItemView(item: .init(id: "123", title: "Sample Task", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false))
}

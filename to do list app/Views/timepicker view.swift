import SwiftUI

struct timePickerview: View {
    @StateObject var viewmodel = TimePickerViewModel()
    @Binding var newItemAdd: Bool

    // State to control the alert
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Name a task")
                    .padding()
                    .font(.system(size: 32))
                
                TextField("ENTER A TASK", text: $viewmodel.title)
                    .frame(width: 360, height: 40)
                    .tint(.red)
                    .padding([.leading, .trailing], 10)
                    .textFieldStyle(.roundedBorder)
                
                Toggle("Schedule for today", isOn: $viewmodel.fortoday)
                    .padding()
                    .onChange(of: viewmodel.fortoday) { isOn in
                        if isOn {
                            // Set due date to today at 12 PM
                            let calendar = Calendar.current
                            var components = calendar.dateComponents([.year, .month, .day], from: Date())
                            components.hour = 12
                            components.minute = 0
                            viewmodel.dueDate = calendar.date(from: components) ?? Date()
                        }
                    }
                
                // Show the DatePicker only if the toggle is off
                if !viewmodel.fortoday {
                    DatePicker("Select a Date", selection: $viewmodel.dueDate, in: Date()...,
                               displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        .padding()
                } else {
                    // Display the selected due date (today at 12 PM)
                    Text("Scheduled for: \(viewmodel.dueDate, formatter: dateFormatter)")
                        .padding()
                }
                
                Spacer()
                
                Button {
                    if viewmodel.isValidTask && viewmodel.isValidDate {
                        // Call the save function to save the task
                        viewmodel.save()
                        newItemAdd = false // Dismiss the sheet
                    } else {
                        // Trigger the alert
                        showAlert = true
                    }
                } label: {
                    Text("Proceed / Add Task")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: 340, height: 44)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding()
            // Alert for validation feedback
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please ensure the task name is not empty and the due date is entered."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Date Formatter to display the selected date in a user-friendly format
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    timePickerview(newItemAdd: .constant(true))
}

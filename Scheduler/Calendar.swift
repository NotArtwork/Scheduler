import SwiftUI

struct TrainingScheduleView: View {
    @State private var selectedDate: Date = Date()
    @State private var upcomingTrainings: [Training] = [
        Training(title: "Yoga Class", date: Date(), coach: "John Doe"),
        Training(title: "Strength Training", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, coach: "Jane Smith"),
        Training(title: "Cardio Session", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, coach: "Mike Johnson")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Using your existing NavigationBarView
                NavigationBarView()
                    .background(Color.white)
                
                // Calendar
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                // List of Trainings
                Text("Upcoming Trainings")
                    .font(.headline)
                    .padding(.top)
                
                List {
                    ForEach(upcomingTrainings.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }, id: \.id) { training in
                        VStack(alignment: .leading) {
                            Text(training.title)
                                .font(.body)
                            
                            HStack {
                                Text(training.date, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("Coach: \(training.coach)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                
                // Bottom Section
                if let upcomingTraining = upcomingTrainings.first(where: { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }) {
                    VStack(alignment: .leading) {
                        Text("Upcoming Class")
                            .font(.headline)
                            .padding(.top)
                        
                        Text("Class: \(upcomingTraining.title)")
                            .font(.subheadline)
                            .padding(.bottom, 2)
                        
                        Text("Time: \(upcomingTraining.date, style: .time)")
                            .font(.subheadline)
                            .padding(.bottom, 2)
                        
                        Text("Coach: \(upcomingTraining.coach)")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Training: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let coach: String
}

struct TrainingScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingScheduleView()
    }
}


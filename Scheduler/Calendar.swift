import SwiftUI

struct TrainingScheduleView: View {
    @State private var selectedDate: Date = Date()
    @State private var upcomingTrainings: [Training] = [
        Training(title: "Yoga Class", date: Date(), coach: "John Doe", spotsLeft: 5),
        Training(title: "Strength Training", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, coach: "Jane Smith", spotsLeft: 2),
        Training(title: "Cardio Session", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, coach: "Mike Johnson", spotsLeft: 8)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
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
                        HStack {
                            VStack(alignment: .leading) {
                                // Class Title above Coach
                                Text(training.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Text("Coach: \(training.coach)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                // Time on the right
                                Text(training.date, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                // Spots left on the right
                                Text("\(training.spotsLeft) spots left")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
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
    let spotsLeft: Int
}

struct TrainingScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingScheduleView()
    }
}


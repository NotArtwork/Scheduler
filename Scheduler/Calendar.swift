import SwiftUI
import UIKit

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
                            Button(action: {
                                
                            }) {
                                Text("Book")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.blue)
                                    .cornerRadius(40)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
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


struct ClassData: Decodable {
    let id: Int
    let title: String
    let date: String
    let start_time: String
    let end_time: String
    let location: String
}

class ClassesViewController: UIViewController {

    // Declare a property to hold the classes data
    var classes: [ClassData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the function to load classes when the view is loaded
        fetchClasses()
    }

    func fetchClasses() {
        // Set the URL for your Flask API endpoint
        guard let url = URL(string: "http://127.0.0.1:5000/classes") else {
            print("Invalid URL")
            return
        }

        // Create a URLSession to make the network request
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            // Check if the response is valid
            guard let data = data else {
                print("No data received")
                return
            }

            // Try to decode the data into an array of ClassData objects
            do {
                let decoder = JSONDecoder()
                let classes = try decoder.decode([ClassData].self, from: data)

                // Update the UI on the main thread
                DispatchQueue.main.async {
                    self.classes = classes
                    self.displayClasses()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }

        // Start the network request
        task.resume()
    }

    func displayClasses() {
        // Here you can update the UI (e.g., display the classes in a table view)
        // For example, if you have a table view:
        for classItem in classes {
            print("Class: \(classItem.title), Date: \(classItem.date), Time: \(classItem.start_time)-\(classItem.end_time), Location: \(classItem.location)")
        }
    }
}

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("username") var username: String = ""
    @AppStorage("image") var image: String =""
    @AppStorage("myclasses") var myclasses: 

    var body: some View {
        if isLoggedIn {
            Text("Welcome, \(username)!")
        } else {
            Text("Please log in.")
        }
    }
}

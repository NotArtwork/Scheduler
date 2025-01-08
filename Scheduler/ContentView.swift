//
//  ContentView.swift
//  Scheduler
//
//  Created by Antonio Arce on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8,
                               maxHeight: UIScreen.main.bounds.height * 0.3)
                        .padding(5)
                Text("Self Defense | Boxing | Jiu Jitzu")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .foregroundColor(.white) // Text color
                        .frame(maxWidth: .infinity) // Make the width span the screen
                        .frame(height: 60) // Set the desired height
                        .background(Color.blue)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9,
                           maxHeight: UIScreen.main.bounds.height * 0.3)
                    .padding(5)
                    Spacer()
                    NavigationLink(destination: LoginView()) {

                    Text("Go to Login Page")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Home") // Title for the initial screen
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
                
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
//                    .border(.red, width: CGFloat(wrongUsername))
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
//                    .border(.red, width: CGFloat(wrongPassword))
                
                Button(action: {
                    authenticateUser(username: username, passwoord: password)
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Sorry 😔"),
                                    message: Text("Wrong password. Please try again."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }

                NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen) {
                    EmptyView()
            }
                
                
            }
            .padding()
            .navigationTitle("Login")
        }
        
    }
    
    
    func authenticateUser(username: String, passwoord: String) {
        if username == "Antonio" {
            wrongUsername = 0
            if passwoord == "12345" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
                showAlert = true
            }
            
        } else {
            // Put an error "user doesn't exist
        }
    }
    
    func login(username: String, password: String) {
        // Backend URL
        let url = URL(string:"127.0.0.1:5000")

        let body: [String: Any] = ["username": username, "password": password]

            guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error creating JSON data")
            return
        }
    }
}


#Preview {
    ContentView()
}

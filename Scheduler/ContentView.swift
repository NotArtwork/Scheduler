//
//  ContentView.swift
//  Scheduler
//
//  Created by Antonio Arce on 1/8/25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8,
                           maxHeight: UIScreen.main.bounds.height * 0.1)
                    .padding(5)
                Text("Self Defense | Boxing | Jiu Jitzu | Kickboxing")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.white) // Text color
                    .frame(maxWidth: .infinity) // Make the width span the screen
                    .frame(height: 40) // Set the desired height
                    .background(Color.blue)
                Image("img1")
                    .resizable() // Make the image resizable
                    .scaledToFill() // Ensures the image fills its frame
                    .frame(width: UIScreen.main.bounds.width, height: 500) // Full screen width, custom height
                    .clipped() // Ensures the image doesn't overflow its frame
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignupView()) {
                        Text("Sign up")
                            .foregroundColor(.blue) // Custom color for "Sign up"
                            .underline() // Optional underline to indicate clickability
                    }
                }
      
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
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
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Button(action: {
                    login(username: username, password: password)
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
                
                NavigationLink(destination: SimplePage(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Login")
        }
        
    }
    
    
    
    
    func login(username: String, password: String) {
        // The URL of your Flask backend (adjust the IP address or hostname accordingly)
        let url = URL(string: "http://127.0.0.1:5000/login")!
        
        // Prepare the JSON data to send in the request body
        let body: [String: Any] = ["username": username, "password": password]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error creating JSON data")
            return
        }
        
        
        // Create the URLRequest with the POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Create the data task using URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check the response status code
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    // Login successful, handle success (maybe save user data)
                    showingLoginScreen = true
                    
                    // Optionally parse the response data to get user ID or other details
                    if let data = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Response: \(jsonResponse)")
                        } catch {
                            print("Error parsing response")
                        }
                    }
                } else {
                    // Invalid credentials
                    showAlert = true
                    //                    print("Invalid credentials, status code: \(response.statusCode)")
                }
            }
        }
        
        // Start the request
        task.resume()
    }
}


struct SignupView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
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
                Text("Sign up")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Button(action: {
                    register(username: username, password: password)
                }) {
                    Text("Sign up")
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
                
                NavigationLink(destination: SimplePage(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Login")
        }
        
    }
    
    
    func register(username: String, password: String) {
        // The URL of your Flask backend (adjust the IP address or hostname accordingly)
        let url = URL(string: "http://127.0.0.1:5000/register")!
        
        // Prepare the JSON data to send in the request body
        let body: [String: Any] = ["username": username, "password": password]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error creating JSON data")
            return
        }
        
        // Create the URLRequest with the POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Create the data task using URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check the response status code
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    // Registration successful, handle success
                    print("Registration successful!")
                    // Optionally, parse the response data to get user ID or other details
                    if let data = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Response: \(jsonResponse)")
                        } catch {
                            print("Error parsing response")
                        }
                    }
                } else {
                    // Registration failed, invalid credentials or username already taken
                    print("Registration failed, status code: \(response.statusCode)")
                    // You could also handle showing an alert or a specific error message
                    // showAlert = true
                }
            }
        }
        
        // Start the request
        task.resume()
    }
}

#Preview {
    ContentView()
}

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
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8,
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
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                // Handle login action here
                print("Login button tapped")
            }) {
                Text("Login")
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
        .padding()
        .navigationTitle("Login")
    }
}


#Preview {
    ContentView()
}


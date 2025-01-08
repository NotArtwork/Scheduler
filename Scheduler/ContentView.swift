//
//  ContentView.swift
//  Scheduler
//
//  Created by Antonio Arce on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    var body: some View {
        NavigationView{
            VStack {
            Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8,
                           maxHeight: UIScreen.main.bounds.height * 0.3)
                    .padding(5)
            Spacer()
            Text("Self Defense | Boxing | Jiu Jitzu")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.white) // Text color
                    .frame(maxWidth: .infinity) // Make the width span the screen
                    .frame(height: 60) // Set the desired height
                    .background(Color.blue)
            }
        }.navigationBarHidden(true)
    }
    

}

#Preview {
    ContentView()
}

//struct ContentView_Preview:
//    PreviewProvider {
//    static var previews: some View{
//        ContentView()
//    }
//}

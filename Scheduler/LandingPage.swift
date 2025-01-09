//
//  LandingPage.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/8/25.
//

import SwiftUI

struct SimplePage: View {
    var body: some View {
        VStack {
            Text("Hello, user")
                .font(.largeTitle)
                .padding()

            Image(systemName: "person.circle") // You can replace this with your image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
        }
        .padding()
    }
}
//
//struct SimplePage_Previews: PreviewProvider {
//    static var previews: some View {
//        SimplePage()
//    }
//}

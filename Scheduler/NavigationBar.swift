//
//  NavigationBar.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/12/25.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        HStack {
            Image("user") // Replace with the actual image name
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.leading)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    print("Search tapped")
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    print("Menu tapped")
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color.white)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}

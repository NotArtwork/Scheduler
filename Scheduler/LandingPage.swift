//
//  LandingPage.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/8/25.
//

import SwiftUI

struct UserPageView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Top Bar
                HStack {
                    Image("user")
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
                .padding(.top)
                
                SectionView(title: "NEWS")
                
                SectionView(title: "CLASSES")
                
                SectionView(title: "TUTORIALS")
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SectionView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<10) { index in
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// Preview
struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserPageView()
    }
}

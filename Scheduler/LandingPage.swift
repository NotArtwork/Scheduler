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
            ZStack(alignment: .top) {
                // Scrollable Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Add some spacing to push content below the fixed top bar
                        Spacer().frame(height: 100)
                        
                        // Sections with images
                        SectionView(title: "News", images: ["img1", "img2", "img3", "img4", "img5"])
                        SectionView(title: "Classes", images: ["img1", "img2", "img3", "img4", "img5"])
                        SectionView(title: "Tutorials", images: ["img1", "img2", "img3", "img4", "img5"])
                        SectionView(title: "Events", images: ["img1", "img2", "img3", "img4", "img5"])
                        SectionView(title: "Articles", images: ["img1", "img2", "img3", "img4", "img5"])
                        
                        Spacer() // Optional bottom padding
                    }
                    .padding(.horizontal)
                }
                
                // Fixed Top Bar
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
//                .frame(height: 100)
                .background(Color.white)
            }
            .navigationBarHidden(true)
        }
    }
}

struct SectionView: View {
    let title: String
    let images: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.headline)
                .padding(.horizontal)
            
            // Horizontal Scroll View
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 160)
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

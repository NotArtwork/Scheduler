//
//  Profile.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/12/25.
//
import SwiftUI

struct UserProfileView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Scrollable Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Adjusted spacing
                        Color.clear.frame(height: 80) // Reduced height to match the top bar size
                        
                        // Sections with images
                        ProfileSectionView(title: "My Classes", images: ["class1", "class2", "class3"])
                        ProfileSectionView(title: "Subscription", images: ["sub1", "sub2", "sub3"])
                        ProfileSectionView(title: "Messages", images: ["msg1", "msg2", "msg3"])
                        ProfileSectionView(title: "My Tutorials", images: ["tutorial1", "tutorial2", "tutorial3"])
                        
                        Spacer() // Optional bottom padding
                    }
                    .padding(.horizontal)
                }
                
                // Fixed Top Bar
                HStack {
                    Image("profileImage")
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
                .frame(height: 80) // Ensure height matches the placeholder
                .background(Color.white.shadow(radius: 2))
                .edgesIgnoringSafeArea(.top) // Extend into the safe area
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfileSectionView: View {
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
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
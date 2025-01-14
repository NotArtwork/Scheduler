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
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Color.clear.frame(height: 80)
                        
                        // Sections with images
                        ProfileSectionView(title: "My Classes", images: ["img1", "img2", "img3", "img4", "img5"])
                        ProfileSectionView(title: "Subscription", images: ["sub1", "sub2", "sub3"])
                        
                        UserMessagesPreview(users: [
                                                    User(id: "1", firstName: "John", profileImage: "user"),
                                                    User(id: "2", firstName: "Emma", profileImage: "user"),
                                                    User(id: "3", firstName: "Ryan", profileImage: nil),
                                                    User(id: "4", firstName: "Sophia", profileImage: "user"),
                                                    User(id: "4", firstName: "Antonio", profileImage: "user")
                                                ])
                        ProfileSectionView(title: "My Tutorials", images: ["img1", "img2", "img3", "img4", "img5"])
                        
                        Spacer() // Optional bottom padding
                    }
//            
                }
                
                NavigationBarView()
                .background(Color.white)
            }
            .navigationBarHidden(true)
        }
    }
}

struct UserMessagesPreview: View {
    let users: [User] // List of users for displaying profile images and names
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Messages".uppercased())
                .font(.headline)
                .padding(.horizontal)
            
            // Horizontal Scroll View for user profile images
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(users, id: \.id) { user in
                        VStack {
                            // Profile Image
                            Image(user.profileImage ?? "user")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                            // User First Name
                            Text(user.firstName)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.top, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// User model for testing
struct User: Identifiable {
    var id: String
    var firstName: String
    var profileImage: String?
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

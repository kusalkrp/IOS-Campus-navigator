//
//  ProfileView.swift
//  IOS
//
//  Created by Kusal Punchihewa on 2025-06-13.
//


import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom header with back button and status bar
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }

                Text("Profile")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 8)
            
            ScrollView {
                // Profile Header
                VStack(spacing: 16) {
                    // Profile Avatar
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 100, height: 100)
                        
                        // Simple avatar representation
                        Image(systemName: "person.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                    
                    // User Info
                    VStack(spacing: 4) {
                        Text("Kavishka")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Kavishka@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 30)
                
                // Menu Items
                VStack(spacing: 0) {
                    ProfileMenuItem(
                        title: "Settings",
                        subtitle: "Personal details, verifications, delete account",
                        icon: "gearshape.fill"
                    )
                    
                    ProfileMenuItem(
                        title: "Security",
                        subtitle: "2FA, PIN & Biometrics",
                        icon: "shield.fill"
                    )
                    
                    ProfileMenuItem(
                        title: "Saved Locations",
                        subtitle: "Manage your favorite campus locations",
                        icon: "location.fill"
                    )
                    
                    ProfileMenuItem(
                        title: "My Bookings",
                        subtitle: "View your study room reservations",
                        icon: "book.fill"
                    )
                    
                    ProfileMenuItem(
                        title: "About Campus Navigator",
                        subtitle: "Version 1.0.0",
                        icon: "info.circle.fill"
                    )
                }
                .padding(.bottom, 30)
                
                // Logout Button - Moved up to make room for navbar
                Button(action: {
                    // Handle logout
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                
            }
        }
        .navigationBarHidden(true)
      //  .withStatusBar() // Using the same status bar modifier as other pages
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ProfileMenuItem: View {
    let title: String
    let subtitle: String?
    let icon: String
    
    var body: some View {
        Button(action: {
            // Handle menu item tap
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 20)
        .padding(.vertical, 1)
    }
}


// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



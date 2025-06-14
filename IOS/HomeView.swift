
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Main content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Greeting and profile icon
                        HStack {
                            Text("Hi, Isurujith!!")
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            // Profile icon with NavigationLink
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 35))
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        
                        // Tiles row
                        HStack(spacing: 20) {
                            // Blue tile - Find your Spot
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.blue)
                                    .frame(height: 180)
                                    .onTapGesture {
                                        print("Find your Spot tile tapped")
                                    }
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Find your Spot")
                                        .font(.system(size: 27))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.top,16)
                                        .padding(.leading, 16)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        // Play button with white background
                                        Button(action: {
                                            print("Play button tapped")
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 40, height: 40)
                                                
                                                Image(systemName: "play.fill")
                                                    .font(.system(size:  16))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .padding(.leading, 16)
                                        .padding(.bottom, 16)
                                        
                                        Spacer()
                                        
                                        // Book now button
                                        NavigationLink(destination: ResourcesView()) {
                                            Text("Book Now")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color.black)
                                                )
                                        }
                                        .padding(.trailing, 16)
                                        .padding(.bottom, 16)
                                    }
                                }
                            }
                            
                            // Card 2 style
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 180)
                                    .onTapGesture {
                                        print("Enjoy your time tile tapped")
                                    }
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Enjoy your time")
                                        .font(.system(size: 27))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding(.top, 16)
                                        .padding(.leading, 16)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        // Play button with white background
                                        Button(action: {
                                            print("Play button tapped on second card")
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 40, height: 40)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 3)
                                                
                                                Image(systemName: "play.fill")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding(.leading, 16)
                                        .padding(.bottom, 16)
                                        
                                        Spacer()
                                        
                                        // Events button
                                        NavigationLink(destination: EventsView()) {
                                            Text("Events")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color.blue)
                                                )
                                        }
                                        .padding(.trailing, 16)
                                        .padding(.bottom, 16)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                        
                        // Live Updates section
                        Text("Live Updates")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                        
                        // Live update cards - stacked vertically
                        VStack(spacing: 16) {
                            // First update card - IOS lab Availability
                            NavigationLink(destination: ResourcesView()) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("IOS lab Availability")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        
                                        HStack(spacing: 8) {
                                            Text("2 min ago")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.blue)
                                                )
                                            
                                            Text("Main lab")
                                                .font(.caption2)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.white)
                                                )
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.1))
                                )
                                .frame(maxWidth: .infinity)
                            }
                            
                            // Second update card
                            NavigationLink(destination: ResourcesView()) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Seminar Room Status")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        
                                        HStack(spacing: 8) {
                                            Text("5 min ago")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.blue)
                                                )
                                            
                                            Text("Room 401")
                                                .font(.caption2)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.white)
                                                )
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.1))
                                )
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Navigation section
                        Text("Navigation")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                        
                        // Map card
                        NavigationLink(destination: NavigationMapView()) {
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Image("map")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 160)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                
                                // Title
                                Text("Campus Map")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                // Description
                                Text("Tap to view the map")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
                            )
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            //.withStatusBar()  // Using the custom status bar
        }
    }
}

// Move the preview provider outside the view struct
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView()
    }
    
}

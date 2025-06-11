import SwiftUI

struct NavigationMapView: View {
    @State private var selectedTab: Int = 0
    @State private var campus: String = ""
    @State private var location: String = ""
    @State private var destination: String = ""
    @State private var wheelchairAccessible: Bool = false
    @State private var saveLocation: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Text("Navigation")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 55)
            
            // Tab selector
            HStack(spacing: 0) {
                ForEach(0..<2) { index in
                    Button(action: {
                        selectedTab = index
                    }) {
                        Text(index == 0 ? "Navigation" : "Saved Location")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                }
            }
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.blue)
                    .offset(x: selectedTab == 0 ? -UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width / 2)
                    .animation(.spring(), value: selectedTab),
                alignment: .bottom
            )
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3)),
                alignment: .bottom
            )
            .padding(.top, 20)
            
            // Content based on selected tab
            TabView(selection: $selectedTab) {
                // Navigation tab
                NavigationContent(
                    campus: $campus,
                    location: $location,
                    destination: $destination,
                    wheelchairAccessible: $wheelchairAccessible,
                    saveLocation: $saveLocation
                )
                .tag(0)
                
                // Saved Location tab
                SavedLocationsContent()
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .withStatusBar() // Using our custom status bar
    }
}

// Navigation tab content
struct NavigationContent: View {
    @Binding var campus: String
    @Binding var location: String
    @Binding var destination: String
    @Binding var wheelchairAccessible: Bool
    @Binding var saveLocation: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Title
                HStack(alignment: .center, spacing: 8) {
                    Text("Find ")
                        .foregroundColor(.black)
                    + Text("Your ")
                        .foregroundColor(.blue)
                    + Text("Place")
                        .foregroundColor(.black)
                    
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 30, weight: .bold))
                        
                        
                }
                .font(.system(size: 48, weight: .bold))
                .padding(.top, 25)
                .padding(.bottom, 20)
                
                // Input fields
                VStack(spacing: 18) {
                    // Campus field
                    TextField("Select Campus", text: $campus)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    // Current location field
                    TextField("Enter your location", text: $location)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    // Destination field
                    TextField("Destination", text: $destination)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // Accessibility option
                HStack {
                    Text("Include Wheelchair-accessible paths")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Toggle("", isOn: $wheelchairAccessible)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .padding(.top, 10)
                
                // Save location option
                HStack {
                    Spacer()
                    
                    Button(action: {
                        saveLocation.toggle()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: saveLocation ? "checkmark.square.fill" : "square")
                                .foregroundColor(saveLocation ? .blue : .gray)
                                .font(.system(size: 20))
                            
                            Text("Save this location")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                
                // Start Navigation button
                Button(action: {
                    // Handle navigation start
                    print("Starting navigation")
                }) {
                    Text("Start Navigation")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .cornerRadius(24)
                }
                .padding(.top, 10)
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 25)
        }
    }
}

// Saved Locations tab content
struct SavedLocationsContent: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Your Saved Locations")
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                // Saved location cards
                ForEach(1...5, id: \.self) { index in
                    SavedLocationCard(
                        title: savedLocations[index-1].title,
                        description: savedLocations[index-1].description,
                        date: savedLocations[index-1].date
                    )
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 40)
        }
    }
    
    // Sample data
    private let savedLocations = [
        SavedLocation(title: "IOS Lab", description: "Main Building, 4th Floor", date: "Yesterday"),
        SavedLocation(title: "Library", description: "Central Campus", date: "3 days ago"),
        SavedLocation(title: "Cafeteria", description: "Student Center, Ground Floor", date: "1 week ago"),
        SavedLocation(title: "Engineering Block", description: "North Campus, Building E", date: "2 weeks ago"),
        SavedLocation(title: "Sports Complex", description: "South Campus", date: "3 weeks ago")
    ]
}

// Saved Location Card
struct SavedLocationCard: View {
    let title: String
    let description: String
    let date: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 44))
                .foregroundColor(.blue)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Text(date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 6)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
        .padding(.vertical, 4)
    }
}

// Model for saved location
struct SavedLocation {
    let title: String
    let description: String
    let date: String
}

struct NavigationMapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMapView()
    }
}

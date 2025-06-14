import SwiftUI

struct IndoorNavigationView: View {
    var buildingName: String
    var destination: String
    var floor: Int = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    // Sample instructions - in real app these would come from a navigation service
    private let navigationSteps = [
        "Enter through the main entrance",
        "Go straight ahead and take the stairs to floor 3",
        "Turn left at the water fountain",
        "Room 304 will be on your right"
    ]
    
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

                Text("Indoor Navigation")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .padding(.bottom, 8)
            
            // Building and destination info
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(buildingName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Floor \(floor)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(destination)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.1))
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10) // Reduced from 15
            
            // 2D building map
            ZStack {
                // Building floor plan
                IndoorMapView(floor: floor, destinationRoom: destination)
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.35) // Reduced from 0.4 to 0.35
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                
                // Floor selector
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 8) {
                            Button(action: {
                                // Action for going up a floor
                            }) {
                                Image(systemName: "chevron.up")
                                    .foregroundColor(.primary)
                                    .padding(10) // Reduced from 12
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }
                            
                            Text("\(floor)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)
                                .frame(width: 30, height: 30)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                            
                            Button(action: {
                                // Action for going down a floor
                            }) {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.primary)
                                    .padding(10) // Reduced from 12
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }
                        }
                        .padding(.trailing, 25) // Reduced from 30
                        .padding(.top, 15) // Reduced from 20
                    }
                    
                    Spacer()
                }
            }
            .padding(.bottom, 5) // Added small padding
            
            // Navigation instructions card
            VStack(alignment: .leading, spacing: 12) { // Reduced spacing from 15 to 12
                HStack {
                    Image(systemName: "map")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    Text("Navigation Instructions")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                
                ForEach(0..<navigationSteps.count, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) { // Reduced from 15 to 12
                        Text("\(index + 1)")
                            .font(.system(size: 14, weight: .bold)) // Reduced from 16
                            .foregroundColor(.white)
                            .frame(width: 22, height: 22) // Reduced from 24x24
                            .background(Circle().fill(Color.blue))
                        
                        Text(navigationSteps[index])
                            .font(.system(size: 15)) // Reduced from 16
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                }
                
                NavigationLink(destination: SuccessView()) {
                    Text("Confirm your Arrival")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(24)
                }
                .padding(.top, 8) // Reduced from 10
            }
            .padding(16) // Reduced from 20
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 20)
            .padding(.top, 10) // Reduced from 15
            .padding(.bottom, 10) // Reduced from 20
            
            // Space for navbar
            Color.clear
                .frame(height: 80) // Added space for navbar
        }
        .navigationBarHidden(true)
        //.withStatusBar()
        .edgesIgnoringSafeArea(.bottom) // Allow content to extend to bottom edge
    }
}

// Indoor Map View - Renders a 2D model of the building
struct IndoorMapView: View {
    var floor: Int
    var destinationRoom: String
    
    // For pinch to zoom and drag
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var selectedRoom: String? = nil
    
    var body: some View {
        ZStack {
            // Background color for the floor
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Building outline
            buildingOutline
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = CGSize(
                                width: self.lastOffset.width + gesture.translation.width,
                                height: self.lastOffset.height + gesture.translation.height
                            )
                        }
                        .onEnded { _ in
                            self.lastOffset = self.offset
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / self.lastScale
                            self.lastScale = value
                            
                            // Limiting the scale factor to reasonable bounds
                            let newScale = self.scale * delta
                            if newScale >= 0.5 && newScale <= 3.0 {
                                self.scale = newScale
                            }
                        }
                        .onEnded { _ in
                            self.lastScale = 1.0
                        }
                )
            
            // Control overlays positioned absolutely
            VStack {
                Spacer()
                
                // Room info popup if a room is selected
                if let selectedRoom = selectedRoom {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Room \(selectedRoom)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            if selectedRoom == "304" {
                                Text("CS Lecture Hall")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .font(.caption)
                                    Text("Capacity: 120")
                                        .font(.caption)
                                }
                                .foregroundColor(.secondary)
                            } else if selectedRoom == "302" {
                                Text("Lab Room")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("Classroom")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Button(action: {
                                // Close info
                                self.selectedRoom = nil
                            }) {
                                Text("Close")
                                    .font(.caption)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                            }
                            .padding(.top, 4)
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
                        )
                        .padding(.trailing, 12)
                        .padding(.bottom, 10)
                    }
                }
            }
        }
    }
    
    // Building layout for the selected floor
    private var buildingOutline: some View {
        ZStack {
            // Main building outline with more realistic proportions
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 340, height: 220)
                .background(Color.white)
            
            // Main corridor
            Path { path in
                path.move(to: CGPoint(x: 20, y: 110))
                path.addLine(to: CGPoint(x: 320, y: 110))
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 20)
            
            // Side corridors
            Path { path in
                path.move(to: CGPoint(x: 160, y: 40))
                path.addLine(to: CGPoint(x: 160, y: 180))
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 16)
            
            // Rooms on top side - more detailed
            ForEach(0..<3) { i in
                let roomNumber = String(format: "%03d", 301 + i)
                let position = CGPoint(x: 65 + CGFloat(i) * 105, y: 55)
                let isDestination = roomNumber == "304"
                let isSelected = selectedRoom == roomNumber
                
                RoomView(
                    roomNumber: roomNumber,
                    position: position,
                    isDestination: isDestination,
                    isSelected: isSelected,
                    onTap: {
                        withAnimation(.spring()) {
                            self.selectedRoom = roomNumber
                        }
                    }
                )
            }
            
            // Rooms on bottom side - more detailed
            ForEach(0..<3) { i in
                let roomNumber = String(format: "%03d", 304 + i)
                let position = CGPoint(x: 65 + CGFloat(i) * 105, y: 165)
                let isDestination = roomNumber == "304"
                let isSelected = selectedRoom == roomNumber
                
                RoomView(
                    roomNumber: roomNumber,
                    position: position,
                    isDestination: isDestination,
                    isSelected: isSelected,
                    onTap: {
                        withAnimation(.spring()) {
                            self.selectedRoom = roomNumber
                        }
                    }
                )
            }
            
            // Special rooms and facilities
            Group {
                // Elevator
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "elevator")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                }
                .position(x: 25, y: 110)
                
                // Stairs
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "stairs")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                }
                .position(x: 315, y: 110)
                
                // Restrooms
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 30, height: 25)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "figure.dress")
                            .font(.system(size: 12))
                        Image(systemName: "figure")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.primary)
                }
                .position(x: 160, y: 40)
                
                // Water fountain
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 15, height: 15)
                    
                    Image(systemName: "drop.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.blue)
                }
                .position(x: 160, y: 140)
            }
            
            // Current position marker
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 15, height: 15)
                
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 15, height: 15)
                
                // Directional indicator
                Image(systemName: "location.north.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
            .position(x: 25, y: 110)
            
            // Navigation path - enhanced with curves
            Path { path in
                path.move(to: CGPoint(x: 25, y: 110)) // Start
                path.addLine(to: CGPoint(x: 160, y: 110)) // Main corridor
                path.addLine(to: CGPoint(x: 160, y: 140)) // Turn
                path.addArc(
                    center: CGPoint(x: 170, y: 140),
                    radius: 10,
                    startAngle: .degrees(180),
                    endAngle: .degrees(90),
                    clockwise: false
                )
                path.addLine(to: CGPoint(x: 170, y: 165)) // to destination
            }
            .stroke(style: StrokeStyle(lineWidth: 3, dash: [5, 3]))
            .foregroundColor(.blue)
            
            // Distance markers
            Text("15m")
                .font(.system(size: 8))
                .foregroundColor(.blue)
                .position(x: 85, y: 100)
            
            Text("8m")
                .font(.system(size: 8))
                .foregroundColor(.blue)
                .position(x: 170, y: 130)
        }
    }
}

// Room View Component for better reusability and interaction
struct RoomView: View {
    var roomNumber: String
    var position: CGPoint
    var isDestination: Bool
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        ZStack {
            // Room background
            Rectangle()
                .fill(isDestination ? Color.red.opacity(0.15) : Color.white)
                .frame(width: 85, height: 40)
                .overlay(
                    Rectangle()
                        .stroke(isSelected ? Color.blue : Color.gray, lineWidth: isSelected ? 2 : 1)
                )
            
            // Room number
            VStack(spacing: 2) {
                Text(roomNumber)
                    .font(.system(size: 12, weight: isDestination ? .bold : .regular))
                    .foregroundColor(isDestination ? .red : .gray)
                
                if isDestination {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
            }
        }
        .position(x: position.x, y: position.y)
        .onTapGesture {
            onTap()
        }
    }
}

struct IndoorNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IndoorNavigationView(
            buildingName: "Computer Science Building",
            destination: "Room 304 - Lecture Hall",
            floor: 3
        )
    }
}

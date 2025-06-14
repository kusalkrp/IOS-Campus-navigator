import SwiftUI

struct MapRoutingView: View {
    var destination: String
    var isWheelchairAccessible: Bool
    @State private var searchText: String = ""
    @State private var estimatedTime: String = "15 min"
    @State private var distance: String = "0.7 miles"
    @State private var currentLocation: String = "Your Location"

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            // ✅ Fixed Header
           
            HStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }


                Text("Route Map")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

               Spacer()

            }
            .padding(.horizontal,60)
            .padding(.top,20) // Added padding for status bar
            .padding(.bottom, 25) // Reduced bottom padding
            
            // ✅ Route Info Card
            RouteInfoCard(
                currentLocation: currentLocation,
                destination: destination,
                estimatedTime: estimatedTime,
                distance: distance,
                isWheelchairAccessible: isWheelchairAccessible
            )
            //.padding(.top, 0) // Removed top padding to bring it closer to title
            .padding(.horizontal, 60)
            .padding(.bottom,20)

            
            ZStack {
                MapView(
                    currentLocation: currentLocation,
                    destination: destination,
                    isWheelchairAccessible: isWheelchairAccessible
                )
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height * 0.5)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: IndoorNavigationView(
                                buildingName: destination,
                                destination: "Room 304",
                                floor: 1
                            )
                        ) {
                            HStack(spacing: 8) {
                                Image(systemName: "building.2.fill")
                                    .font(.title3)
                                Text("View Building")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                        }
                        .padding(.trailing, 50)
                        .padding(.bottom, 20)
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
            }
            
            // Search bar below map
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search nearby places", text: $searchText)
                    .font(.system(size: 16))
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 60)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 60)
            .padding(.top, 20)
        }
        .navigationBarHidden(true)
      //  .withStatusBar() // Moved here to apply to the entire view
    }
}

// ✅ Route Info Card
struct RouteInfoCard: View {
    var currentLocation: String
    var destination: String
    var estimatedTime: String
    var distance: String
    var isWheelchairAccessible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    // Current location
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)

                        Text(currentLocation)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                    }

                    // Dotted line
                    VStack(spacing: 2) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 3, height: 3)
                        }
                    }
                    .frame(height: 16)

                    // Destination
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 16))

                        Text(destination)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.leading, 4)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 5) {
                    Text(estimatedTime)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.blue)

                    Text(distance)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)

                    if isWheelchairAccessible {
                        HStack {
                            Image(systemName: "figure.roll")
                                .foregroundColor(.blue)
                            Text("Accessible")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }

            Divider()
                .padding(.vertical, 4)

            HStack {
                Button(action: {
                    // Share action
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                }

                Spacer()

                Button(action: {
                    // Options action
                }) {
                    HStack {
                        Image(systemName: "ellipsis")
                        Text("Options")
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                }
            }
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.gray).opacity(0.1))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

struct MapView: View {
    var currentLocation: String
    var destination: String
    var isWheelchairAccessible: Bool

    var body: some View {
        ZStack {
            Image("campus")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Start marker
            VStack(spacing: 5) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 40)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )

                Text("Start")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(4)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(4)
            }
            .position(x: UIScreen.main.bounds.width * 0.35,
                      y: UIScreen.main.bounds.height * 0.42)

            // Destination marker
            VStack(spacing: 0) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.red)

                Text("Destination")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(4)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(4)
            }
            .position(x: UIScreen.main.bounds.width * 0.45,
                      y: UIScreen.main.bounds.height * 0.3)

            // Route line
            Path { path in
                path.move(to: CGPoint(x: UIScreen.main.bounds.width * 0.38,
                                      y: UIScreen.main.bounds.height * 0.4))
                path.addCurve(
                    to: CGPoint(x: UIScreen.main.bounds.width * 0.45,
                                y: UIScreen.main.bounds.height * 0.30),
                    control1: CGPoint(x: UIScreen.main.bounds.width * 0.45,
                                      y: UIScreen.main.bounds.height * 0.56),
                    control2: CGPoint(x: UIScreen.main.bounds.width * 1.6,
                                      y: UIScreen.main.bounds.height * 0.3)
                )
            }
            .stroke(Color.blue, lineWidth: 7)
        }
    }
}

struct MapRoutingView_Previews: PreviewProvider {
    static var previews: some View {
        MapRoutingView(
            destination: "IOS Lab",
            isWheelchairAccessible: true
        )
    }
}

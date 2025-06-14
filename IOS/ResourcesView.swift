import SwiftUI

struct ResourcesView: View {
    @State private var showBooking = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Current Status Card
                    Card {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Current Status")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("• Available")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                            HStack(spacing: 20) {
                                StatColumn(number: "12", label: "Study Rooms")
                                StatColumn(number: "8", label: "Occupied")
                                StatColumn(number: "60%", label: "Capacity")
                            }
                        }
                    }
                    // Bookings Card
                    Card {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Bookings")
                                .fontWeight(.semibold)
                            HStack(spacing: 32) {
                                StatColumn(number: "2", label: "Active Bookings")
                                StatColumn(number: "10", label: "Total Bookings")
                            }
                        }
                    }
                    // Available Resources
                    Text("Available Recourses")
                        .font(.headline)
                        .padding(.horizontal)
                    VStack(spacing: 16) {
                        ResourceCard(
                            title: "Study Rooms",
                            time: "8:00 AM - 5:00PM",
                            status: "Open",
                            statusColor: .green
                        ) {
                            showBooking = true
                        }
                        ResourceCard(
                            title: "Library",
                            time: "8:00 AM - 5:00PM",
                            status: "Closed",
                            statusColor: .red
                        ) {
                            showBooking = true
                        }
                        ResourceCard(
                            title: "Cafeteria",
                            time: "8:00 AM - 5:00PM",
                            status: "Open",
                            statusColor: .green
                        ) {
                            showBooking = true
                        }
                        ResourceCard(
                            title: "Lecture",
                            time: "8:00 AM - 5:00PM",
                            status: "Available",
                            statusColor: .green
                        ) {
                            showBooking = true
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Resources")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "person.crop.circle")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(isPresented: $showBooking) {
                StudyRoomBookingView()
            }
        }
    }
}

struct Card<Content: View>: View {
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct StatColumn: View {
    let number: String
    let label: String

    var body: some View {
        VStack {
            Text(number)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Text(label)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResourceCard: View {
    let title: String
    let time: String
    let status: String
    let statusColor: Color
    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .fontWeight(.semibold)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(status)
                    .font(.caption2)
                    .foregroundColor(statusColor)
            }
            Spacer()
            Button(action: action) {
                Text("Book")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}

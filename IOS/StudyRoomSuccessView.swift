import SwiftUI

struct StudyRoomSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Success Message Section
                VStack(spacing: 16) {
                    Text("Success!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.blue)

                    Text("Your Study Room has been successfully booked.")
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                }
                .padding(.top, 30)

                // Success Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                        .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)

                    Image(systemName: "checkmark")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)

                // Booking Details
                VStack(alignment: .leading, spacing: 6) {
                    Text("Booking Details")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 0) {
                        BookingDetailRow(label: "Study Room Type", value: "Computer Lab")
                        Divider()
                        BookingDetailRow(label: "Date", value: "Tuesday, June 4, 2025")
                        Divider()
                        BookingDetailRow(label: "Duration", value: "2:30 PM - 4:00 PM")
                        Divider()
                        BookingDetailRow(label: "Number of People", value: "3")
                        Divider()
                        BookingDetailRow(label: "Location", value: "Building A, 2nd Floor")
                        Divider()
                        BookingDetailRow(label: "Booking ID", value: "#LAB230547")
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 30)

                // Done Button
                Button(action: {
                    // Pop to root view
                    dismiss()
                }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(24)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Booking Confirmed")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "person.crop.circle")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
            }
        }
        //.withStatusBar()
    }
}

struct BookingDetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)

            Spacer()

            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 25)
    }
}
// Add this to your app for centralized navigation
class NavigationController: ObservableObject {
    enum Destination: Hashable {
        case studyRoomBooking
        case success
        case resources
    }
    
    @Published var path: [Destination] = []
}

struct StudyRoomSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StudyRoomSuccessView()
                .environmentObject(NavigationController())
        }
    }
}

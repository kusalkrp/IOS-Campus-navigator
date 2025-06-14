import SwiftUI

struct StudyRoomApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    var body: some View {
        NavigationStack {
            StudyRoomBookingView()
        }
    }
}

struct StudyRoomBookingView: View {
    @State private var selectedRoomType = ""
    @State private var selectedDate = Date()
    @State private var selectedStartTime = Date()
    @State private var selectedEndTime = Date()
    @State private var numberOfStudents = ""
    @State private var showSuccess = false

    let roomTypes = ["Small Room", "Medium Room", "Large Room"]

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                HStack {
                    Text("Select Room Details")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.top, 30)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Room Type")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.secondary)

                    Menu {
                        ForEach(roomTypes, id: \.self) { type in
                            Button(type) {
                                selectedRoomType = type
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedRoomType.isEmpty ? "Select room type" : selectedRoomType)
                                .foregroundColor(selectedRoomType.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Date")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.secondary)

                    HStack {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }

                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Start Time")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.secondary)

                        DatePicker("", selection: $selectedStartTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("End Time")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.secondary)

                        DatePicker("", selection: $selectedEndTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Number of Students")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.secondary)

                    TextField("Enter number", text: $numberOfStudents)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }

                Spacer()

                Button(action: {
                    showSuccess = true
                }) {
                    Text("Confirm Booking")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(24)
                }
                .padding(.bottom, 30)

                Spacer()
                    .frame(height: 20)
            }
            .padding(.horizontal, 25)
        }
        .navigationTitle("Study Room Booking")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.primary)
                }
            }
        }
        //.withStatusBar()
        .fullScreenCover(isPresented: $showSuccess) {
            StudyRoomSuccessView()
        }
    }
}

struct StudyRoomBookingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

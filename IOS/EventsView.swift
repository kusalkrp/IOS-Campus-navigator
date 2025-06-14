
import SwiftUI

struct EventsView: View {
    enum Destination: Hashable {
        case educationalDetails
        case concertDetails(title: String)
    }

    @State private var path: [Destination] = []

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 24) {
                    // Educational Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Educational")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)

                        EducationalEventCard {
                            path.append(.educationalDetails)
                        }
                        .padding(.horizontal, 20)
                    }

                    // Concerts Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Concerts")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ConcertEventCard(
                                    title: "Music Duo",
                                    subtitle: "Live performance",
                                    imageName: "duo",
                                    date: "June 15"
                                ) {
                                    path.append(.concertDetails(title: "Music Duo"))
                                }

                                ConcertEventCard(
                                    title: "Night Concert",
                                    subtitle: "Special show",
                                    imageName: "night",
                                    date: "June 22"
                                ) {
                                    path.append(.concertDetails(title: "Night Concert"))
                                }

                                ConcertEventCard(
                                    title: "Jazz Night",
                                    subtitle: "Top performers",
                                    imageName: "jazz",
                                    date: "July 5"
                                ) {
                                    path.append(.concertDetails(title: "Jazz Night"))
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 5)
                            .padding(.vertical, 10)
                        }
                    }

                    // See more button
                    Button(action: {}) {
                        Text("See more events")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top,-5)
                }
                .padding(.top, 10)

                Color.clear
                    .frame(height: 70)
            }
            .navigationTitle("Events")
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .educationalDetails:
                    EventDetailsView(title: "Educational Event")
                case .concertDetails(let title):
                    EventDetailsView(title: title)
                }
            }
        }
    }
}

struct EducationalEventCard: View {
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Unlock the power of knowledge")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)

                Text("Join us for an inspiring journey of learning, innovation, and growth")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            HStack(spacing: 15) {
                Image("education")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.leading, 20)
                    .padding(.vertical, 15)

                Spacer()

                VStack(alignment: .trailing) {
                    Text("June 24")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)

                    Spacer()

                    Button(action: action) {
                        Text("View Details")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                }
                .padding(.trailing, 20)
                .padding(.vertical, 20)
            }
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct ConcertEventCard: View {
    let title: String
    let subtitle: String
    let imageName: String
    let date: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 15)
            .padding(.top, 15)
            .padding(.bottom, 10)

            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 15)

            HStack {
                Text(date)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)

                Spacer()

                Button(action: action) {
                    Text("Details")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .frame(width: 190)
    }
}

// Dummy event details view
struct EventDetailsView: View {
    let title: String
    var body: some View {
        Text("\(title) Details")
            .font(.largeTitle)
            .padding()
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

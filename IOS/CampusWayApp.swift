import SwiftUI

struct CampusWayView: View {
    @State private var isAnimating = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(1), Color.blue.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 30) {
                    VStack(spacing: 18) {
                        Image(systemName: "map.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(
                                Animation.easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                            .onAppear {
                                isAnimating = true
                            }

                        VStack(spacing: 6) {
                            Text("CampusWay")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)

                            Text("Navigate Your Campus Journey")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.85))
                        }
                    }
                    .padding(.top, 100)

                    Spacer()

                    VStack(alignment: .center, spacing: 16) {
                        VStack(spacing: 4) {
                            Text("Your Campus")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)

                            Text("Navigation Companion")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 16) {
                            FeatureRow(icon: "mappin.and.ellipse", text: "Find lecture halls")
                            FeatureRow(icon: "clock", text: "Check room availability ")
                            FeatureRow(icon: "arrow.triangle.turn.up.right.diamond", text: "Get step-by-step navigation")
                            FeatureRow(icon: "calendar", text: "Stay updated with campus events")
                        }
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        .padding(.horizontal, 20)

                        NavigationLink(destination:
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                        ) {
                            Text("Get Started")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(24)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(28)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -10)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
// Feature row component for white background
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

// Feature row component for gradient background
struct FeatureRowOnGradient: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
}

// Preview provider
struct CampusWayView_Previews: PreviewProvider {
    static var previews: some View {
        CampusWayView()
    }
}

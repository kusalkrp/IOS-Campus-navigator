
import SwiftUI

struct SuccessView: View {
    @State private var showMainTab = false

    var body: some View {
        VStack(spacing: 0) {
            // Content area
            VStack(spacing: 0) {
                // Top spacer to push content down from status bar
                Spacer()
                    .frame(height: 30)
                
                // Success animation area
                ZStack {
                    // Blue circular background
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 200, height: 200)
                    
                    // Success checkmark with blue background
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 40)
                
                // Success text
                Text("Hooray!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("You have successfully reached your destination.")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 8)
                
                // Spacer to push content up
                Spacer()
                
                // Exit button
                Button(action: {
                    showMainTab = true
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .cornerRadius(28)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50) // Safe area + padding
            }
        }
        .padding(.top, 40) // Add padding at top for status bar
        //.withStatusBar()
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showMainTab) {
            MainTabView()
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SuccessView()
        }
    }
}

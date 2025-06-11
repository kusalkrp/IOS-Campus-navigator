
import SwiftUI

struct CustomStatusBar: View {
    var body: some View {
        HStack(spacing: 5) {
            // Time with spacer on left side
            Text("9:41 AM")
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Spacer()
            
            // WiFi icon
            Image(systemName: "wifi")
                .font(.system(size: 12))
            
            // Battery
            HStack(spacing: 2) {
                Image(systemName: "battery.100")
                    .font(.system(size: 12))
                Text("100%")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
            }
        }
        .padding(.top, 25)
        .padding(.horizontal, 35)
        .frame(height: 20)
        .background(Color.white)
    }
}

struct StatusBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            CustomStatusBar()
            content
        }
        .edgesIgnoringSafeArea(.top)
    }
}

extension View {
    func withStatusBar() -> some View {
        self.modifier(StatusBarModifier())
    }
}

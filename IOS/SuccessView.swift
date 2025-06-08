import SwiftUI

struct SuccessView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 20) {
                    // Celebration text
                    Text("Hoorayyy!!!")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.top, 60)
                    
                    Text("You have reached to your destination.")
                        .font(.system(size: 36))
                        .foregroundColor(.black)
                        .padding(.top, 5)
                    
                    // Centered tick icon
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 70, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                // Fixed Exit button at bottom
                VStack {
                    Button(action: {
                        // Dismiss the view or perform exit action
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Exit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.blue)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                }
                .padding(.top, 20)
                .background(Color.white)
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white.ignoresSafeArea())
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
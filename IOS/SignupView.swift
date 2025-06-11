
import SwiftUI

struct SignupView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var indexNumber: String = ""
    @State private var campus: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var agreeToTerms: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Spacer()
                   
                    
                    // Scrollable content area
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            // Back arrow
                            Button(action: {
                                // Handle back action
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 24)
                            .padding(.top, 55)
                            
                            // Title
                            VStack(alignment: .leading, spacing: 0) {
                                (
                                    Text("Create")
                                        .foregroundColor(.black)
                                    + Text(" Your")
                                        .foregroundColor(.blue)
                                    + Text(" Account")
                                        .foregroundColor(.black)
                                )
                                .font(.system(size: 48, weight: .bold))
                            }
                            .padding(.leading, 35)
                            .padding(.top, 16)
                            
                            // Input fields
                            VStack(spacing: 20) {
                                TextField("Full Name", text: $fullName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Email", text: $email)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .keyboardType(.phonePad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Index Number", text: $indexNumber)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Campus", text: $campus)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                SecureField("Password", text: $password)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                SecureField("Confirm Password", text: $confirmPassword)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    
                                // Terms and conditions
                                HStack {
                                    Button(action: { agreeToTerms.toggle() }) {
                                        Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                            .foregroundColor(agreeToTerms ? .blue : .gray)
                                    }
                                    Text("I agree to the Terms & Conditions")
                                        .font(.footnote)
                                    Spacer()
                                }
                                .padding(.top, 8)
                                
                                // Add spacer to ensure content can scroll up above the fixed button area
                                Spacer().frame(height: 200)
                            }
                            .padding(.horizontal, 32)
                            .padding(.top, 20)
                        }
                        .withStatusBar()
                    }
                }
                
                // Fixed bottom section with signup button
                VStack(spacing: 16) {
                    Divider()
                        .padding(.horizontal, 32)
                    
                    // Sign up button (fixed position)
                    Button(action: {
                        // Handle sign up
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(24)
                            .font(.headline)
                    }
                    .padding(.horizontal, 32)
                    
                    // Or continue with
                    HStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                        Text("or continue")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .padding(.horizontal, 8)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 32)
                    
                    // Social icons
                    HStack(spacing: 24) {
                        Spacer()
                        ForEach(["facebook", "google", "apple"], id: \.self) { icon in
                            Button(action: {
                                // Handle social signup
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color(.systemGray6))
                                        .frame(width: 44, height: 44)
                                    Image(icon + ".logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    // Already have an account
                    HStack {
                        Spacer()
                        Button(action: {
                            // Navigate to login
                        }) {
                            Text("Already have an account?")
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.top, 16)
                .frame(width: geometry.size.width)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: -5)
                )
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

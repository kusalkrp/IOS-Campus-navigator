import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
                        // Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
             
                Text("Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading)
                
                Spacer()
            }
        
            .padding(.top, 40)
            .padding(.horizontal)
            
           
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // APP Settings Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                            Text("APP SETTINGS")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .padding(.leading)
                        
                        // Settings Options
                        SettingsRow(title: "Edit profile", hasToggle: false) { }
                        
                        SettingsRow(title: "Notification", hasToggle: true, isToggled: $notificationsEnabled)
                        
                        SettingsRow(title: "Dark Mode", hasToggle: true, isToggled: $darkModeEnabled)
                        
                        SettingsRow(title: "Security", hasToggle: false) { }
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Help & Terms Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                            Text("HELP & TERMS OF SERVICE")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .padding(.leading)
                        
                        SettingsRow(title: "Privacy Policy", hasToggle: false) { }
                        
                        SettingsRow(title: "Terms of Use", hasToggle: false) { }
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Account Settings Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "person.circle")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                            Text("ACCOUNT SETTINGS")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .padding(.leading)
                        
                        SettingsRow(title: "Change Username", hasToggle: false) { }
                        
                        SettingsRow(title: "Change Password", hasToggle: false) { }
                        
                        Button(action: {
                            // Delete account action
                        }) {
                            Text("Delete Account")
                                .foregroundColor(.red)
                                .font(.system(size: 16))
                                .padding(.vertical, 14)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .withStatusBar()
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
       }
}

struct SettingsRow: View {
    let title: String
    let hasToggle: Bool
    var isToggled: Binding<Bool>?
    var action: (() -> Void)? = nil
    
    init(title: String, hasToggle: Bool, isToggled: Binding<Bool>? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.hasToggle = hasToggle
        self.isToggled = isToggled
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if !hasToggle, let action = action {
                action()
            }
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                
                Spacer()
                
                if hasToggle, let isToggled = isToggled {
                    Toggle("", isOn: isToggled)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
 
        .padding(.horizontal)
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

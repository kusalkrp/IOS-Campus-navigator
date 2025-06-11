import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .profile
    
    enum Tab: Int, CaseIterable {
        case home, map, resources, events, profile
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .map: return "Map"
            case .resources: return "Resources"
            case .events: return "Events"
            case .profile: return "Profile"
            }
        }
        
        var icon: String {
            switch self {
            case .home: return "house"
            case .map: return "map"
            case .resources: return "folder"
            case .events: return "calendar"
            case .profile: return "person"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .map:
                    NavigationMapView()
                case .resources:
                    Text("Resources Screen")
                case .events:
                    Text("Events Screen")
                case .profile:
                    SettingsView()
                }
            }
            Spacer(minLength: 0)
            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer(minLength: 40)
            ForEach(MainTabView.Tab.allCases, id: \ .self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? .blue : .black)
                            .opacity(0.7)
                        Text(tab.title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(selectedTab == tab ? .blue : .black)
                            .opacity(0.7)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                }
            }
            Spacer(minLength: 30)
        }
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .shadow(color: Color.black.opacity(0.07), radius: 8, y: -2)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

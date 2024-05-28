import SwiftUI

struct MoviesTabView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var rootScreen : RootView
    @State private var selectedTab = 0
        
    var body: some View {
        NavigationStack{
                TabView(selection: $selectedTab){
                    HomeView(rootScreen: $rootScreen)
                        .tabItem { Label("Home", systemImage: "house").padding(.top, 5) }
                        .tag(0)
                    
                    SettingListView(rootScreen: $rootScreen)
                        .tabItem { Label("Account", systemImage: "person").padding(.top, 5) }
                        .tag(1)
                    
                    OrderListView()
                        .tabItem { Label("Order", systemImage: "bag").padding(.top, 5) }
                        .tag(2)
                }
                .onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithDefaultBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
                .environmentObject(fireDBHelper)
                .environmentObject(fireAuthHelper)
        }
    }
}



import SwiftUI

struct MoviesTabView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var rootScreen : RootView
    @State private var selectedTab = 0
    @State private var isLogOut: Bool = false

        
    var body: some View {
        NavigationStack{
//            ZStack{
//                Color.clear
//                    .ignoresSafeArea()
                TabView(selection: $selectedTab){
                    HomeView(rootScreen: $rootScreen)
                        .tabItem { Label("Home", systemImage: "house").padding(.top, 5) }
                        .tag(0)
                    
                    SettingListView()
                        .tabItem { Label("Account", systemImage: "person").padding(.top, 5) }
                        .tag(1)
                    
                    OrderListView()
                        .tabItem { Label("Order", systemImage: "bag").padding(.top, 5) }
                        .tag(2)
                }
                .toolbar {
                    if selectedTab == 1 {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button{
                                isLogOut = true
                            }label:{
                                HStack{
                                    Image(systemName: "figure.walk.arrival")
                                    Text("Log Out")
                                }
                                .foregroundStyle(.orange)
                                .font(.body.bold())
                                .padding(15)
                            }
                            .padding(.vertical, 25)
                            .alert(isPresented: $isLogOut){
                                Alert(title: Text("Log Out"),
                                      message: Text("Do you want to logout?"),
                                      primaryButton: .default(Text("Log Out")) {
                                    rootScreen = .Login
                                    fireAuthHelper.signOut()
                                },
                                      secondaryButton: .cancel()
                                )
                            }
                        }
                    }
                }
                .onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithDefaultBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
                .environmentObject(fireDBHelper)
                .environmentObject(fireAuthHelper)
//            }
        }
    }
}



import SwiftUI

struct MoviesTabView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var rootScreen : RootView
    
    
    var body: some View {
        ZStack{
            TabView {
                HomeView()
                    .tabItem { Label("Home", systemImage: "house").padding(.top, 5) }
                    .environmentObject(fireDBHelper)

                AccountView(rootScreen: $rootScreen)
                    .tabItem { Label("Account", systemImage: "person").padding(.top, 5) }
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
                OrderListView()
                    .tabItem { Label("Order", systemImage: "bag").padding(.top, 5) }
            }
            
        }
    }
}

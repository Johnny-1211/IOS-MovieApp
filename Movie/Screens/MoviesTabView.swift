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
                AccountView()
                    .tabItem { Label("Account", systemImage: "person").padding(.top, 5) }
                OrderListView()
                    .tabItem { Label("Order", systemImage: "bag").padding(.top, 5) }
            }
            
        }
    }
}

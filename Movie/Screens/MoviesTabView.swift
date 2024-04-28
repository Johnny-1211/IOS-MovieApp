import SwiftUI

struct MoviesTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            AccountView()
                .tabItem { Label("Account", systemImage: "person") }
            OrderView()
                .tabItem { Label("Order", systemImage: "bag") }
            //                .badge(order.items.count)
            
        }
    }
}

#Preview {
    MoviesTabView()
}

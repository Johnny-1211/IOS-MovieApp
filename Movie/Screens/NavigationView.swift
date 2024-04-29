import SwiftUI

struct NavigationView: View {
    private let fireDBHelper = FireDBHelper.getInstance()
    var fireAuthHelper = FireAuthHelper()
    
    @State private var root : RootView = .Login
    
    var body: some View {
        NavigationStack {
            switch(root) {
            case .Login:
                LoginView(rootScreen: self.$root)
                    .environmentObject(self.fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .SignUp:
                SignUpView(rootScreen: self.$root)
                    .environmentObject(self.fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .Home:
                MoviesTabView(rootScreen: self.$root)
                    .environmentObject(self.fireDBHelper)
                    .environmentObject(self.fireAuthHelper)
            }
        }
    }
}

#Preview {
    NavigationView()
}

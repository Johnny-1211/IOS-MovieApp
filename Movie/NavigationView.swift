import SwiftUI

struct NavigationView: View {
    private let fireDBHelper = FireDBHelper.getInstance()
    var fireAuthHelper = FireAuthHelper()
    
    @State private var root : RootView = .Login

    var body: some View {
        NavigationStack{
            switch(root) {
            case .Login:
                LoginView(rootScreen: $root)
            case .SignUp:
                SignUpView(rootScreen: $root)
                
            case .Home:
                MoviesTabView(rootScreen: $root)
            }
        }
        .environmentObject(self.fireDBHelper)
        .environmentObject(self.fireAuthHelper)
    }
}



import SwiftUI

struct SettingListView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var isLogOut: Bool = false
    @Binding var rootScreen: RootView
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack(alignment: .leading){
                    VStack(spacing: 10){
                        Text("Account")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top,25)
                    .padding(.horizontal, 20)
                    
                    List{
                        NavigationLink {
                            NameUpdateView()
                        } label: {
                            Text("Update user name")
                        }
                        
                        NavigationLink {
                            EmailUpdateView()
                        } label: {
                            Text("Update email")
                        }
                        
                        NavigationLink {
                            PasswordUpdateView()
                        } label: {
                            Text("Update password")
                        }
                        
                        Button{
                            isLogOut = true
                        }label:{
                            HStack{
                                Image(systemName: "figure.walk.arrival")
                                Text("Log Out")
                            }
                            .foregroundStyle(.red)
                        }
                        .alert(isPresented: $isLogOut){
                            Alert(title: Text("Log Out"),
                                  message: Text("Do you want to logout?"),
                                  primaryButton: .default(Text("Log Out")) {
                                do{
                                    rootScreen = .Login
                                    fireAuthHelper.signOut()
                                }catch let err as NSError{
                                    print(#function, "Logout error: \(err.localizedDescription)")
                                }
                            },
                                  secondaryButton: .cancel()
                            )
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
                }
            }            
        }
    }
}

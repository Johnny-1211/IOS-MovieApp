import SwiftUI

struct AccountView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    //    @StateObject var viewModel = AccountViewModel()
    
    @Binding var rootScreen : RootView
    @State private var userName : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var newPassword : String = ""
    @State private var showingAlert: Bool = false
//    @State private var isLogOut: Bool = false
    
    enum FormTextField {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12){
                    Text("Account")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("User Name")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    
                    TextField("", text: $userName, prompt: Text("Update User Name").foregroundStyle(.gray))
                        .background(.white)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .clipShape(.capsule)
                        .keyboardType(.alphabet)
                        .background{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
                        }
                    
                    Text("Email")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    
                    TextField("", text: $email, prompt: Text("Update Email").foregroundStyle(.gray))
                        .background(.white)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .clipShape(.capsule)
                        .keyboardType(.emailAddress)
                        .background{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
                        }
                    
                    Text("Current Password")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    
                    SecureField("", text: $password, prompt: Text("Current Password").foregroundStyle(.gray))
                        .background(.white)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .clipShape(.capsule)
                        .keyboardType(.alphabet)
                        .background{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
                        }
                    
                    Text("New Password")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    
                    SecureField("", text: $newPassword, prompt: Text("New Password").foregroundStyle(.gray))
                        .background(.white)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .clipShape(.capsule)
                        .keyboardType(.alphabet)
                        .background{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
                        }
                    
                    Button{
                        fireAuthHelper.updateProfile(newName: userName, newEmail: email, currentPassword: password, newPassword: newPassword)
                        showingAlert = true
                    } label: {
                        Text("Save")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.orange)
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    
                    
                    Spacer()
                }
                .padding(20)
                .foregroundStyle(.white)
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button{
//                            isLogOut = true
//                        }label:{
//                            HStack{
//                                Image(systemName: "figure.walk.arrival")
//                                Text("Log Out")
//                            }
//                            .foregroundStyle(.orange)
//                            .font(.body.bold())
//                            .padding(10)
//                            .clipShape(
//                                RoundedRectangle(cornerRadius: 12)
//                            )
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .stroke(.orange, lineWidth: 2)
//                            )
//                        }
//                        .alert(isPresented: $isLogOut){
//                            Alert(title: Text("Log Out"),
//                                  message: Text("Do you want to logout?"),
//                                  primaryButton: .default(Text("Log Out")) {
//                                fireAuthHelper.signOut()
//                                rootScreen = .Login
//                            },
//                                  secondaryButton: .cancel()
//                            )
//                        }
//                    }
//                }
            }
            
        }
    }
}

#Preview {
    @State var rootScreen : RootView = .Home
    
    return AccountView(rootScreen: $rootScreen)
}

import SwiftUI

struct PasswordUpdateView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @StateObject var viewModel = SettingViewModel()
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12){
                Text("Password")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                TextField("", text: self.$viewModel.newPassword, prompt: Text("Update Password")
                    .foregroundStyle(.gray))
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
                
                if let passwordError = viewModel.passwordError{
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                Button{
                    if let passwordError = viewModel.passwordError{
                        self.viewModel.passwordError = "Password is required!"
                    }else{
                        if viewModel.newPassword.count >= 6{
                            Task{
                                do {
//                                    try fireAuthHelper.updatePassword(password: viewModel.newPassword)
                                } catch let err as NSError{
                                    print(#function, "unable to update email: \(err)")
                                }
                            }
                        } else{
                            viewModel.passwordError = "Password must be at least 6 characters long."
                        }
                    }
                }label: {
                    Text("Update")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .background{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.orange)
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                }
                Spacer()
            }
            .padding(20)
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Update success"),
                  message: Text("Your password update was successful"),
                  dismissButton: .default(Text("OK")) {})
        }
    }
}

#Preview {
    PasswordUpdateView()
}

import SwiftUI

struct EmailUpdateView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @StateObject var viewModel = SettingViewModel()
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12){
                Text("Email")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                TextField("", text: self.$viewModel.newEmail, prompt: Text("Update Email")
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
                
                if let emailError = viewModel.emailError{
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                Button{
                    if let emailError = viewModel.emailError{
                        self.viewModel.emailError = "Email is required!"
                    }else{
                        if viewModel.isValidEmail(viewModel.newEmail){
                            Task{
                                do {
//                                    try fireAuthHelper.updateEmail(email: viewModel.newEmail)
//                                    fireDBHelper.updateEmail(email: viewModel.newEmail, uid: fireAuthHelper.user!.uid)
                                } catch let err as NSError{
                                    print(#function, "unable to update email: \(err)")
                                }
                            }
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
                  message: Text("Your email update was successful"),
                  dismissButton: .default(Text("OK")) {})
        }
    }
}

#Preview {
    EmailUpdateView()
}

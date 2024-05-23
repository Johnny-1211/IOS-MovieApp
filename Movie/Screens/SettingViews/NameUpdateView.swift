import SwiftUI

struct NameUpdateView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @StateObject var viewModel = SettingViewModel()
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12){
                Text("User Name")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                TextField("", text: self.$viewModel.userName, prompt: Text("Update User Name").foregroundStyle(.gray))
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
                
                if let nameError = viewModel.nameError{
                    Text(nameError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                Button{
                    if let nameError = viewModel.nameError{
                        self.viewModel.nameError = "User Name is required!"
                    }else{
                        fireDBHelper.updateUserName(name: viewModel.userName)
                        let changeRequest = fireAuthHelper.user?.createProfileChangeRequest()
                        changeRequest?.displayName = viewModel.userName
                        changeRequest?.commitChanges()
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
                  message: Text("Your name update was successful"),
                  dismissButton: .default(Text("OK")) {})
        }
    }
}

#Preview {
    NameUpdateView()
}

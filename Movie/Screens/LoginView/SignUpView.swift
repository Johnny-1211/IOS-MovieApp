import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @Binding var rootScreen : RootView
    
    @State private var userName : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State private var createAccount = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("User Name")
                        .foregroundStyle(.white)
                    TextField("Your user name", text: self.$userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.asciiCapable)
                    
                    Text("Email")
                        .foregroundStyle(.white)
                    TextField("Your email address", text: self.$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Text("Password")
                        .foregroundStyle(.white)
                    SecureField("Enter your password", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                    
                    Text("Password confirmation")
                        .foregroundStyle(.white)
                    SecureField("Enter password again", text: self.$confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                    
                    Button(action: {
                        if (!self.userName.isEmpty && !self.email.isEmpty && !self.password.isEmpty && !self.confirmPassword.isEmpty){
                            if (self.password == self.confirmPassword){
                                self.fireAuthHelper.signUp(userName: self.userName, email: self.email, password: self.confirmPassword)
                                alertItem = AlertContext.registrateSuccess
                                self.rootScreen = .Home
                                
                            } else{
                                alertItem = AlertContext.invaildRegistration
                            }
                        }else{
                            alertItem = AlertContext.emptyField
                            print(#function, "email and password cannot be empty")
                        }
                    }){
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.vertical, 10)
                }
                .padding(.horizontal,20)
                .alert(item: $alertItem){ alert in
                    Alert(title: alert.title,
                          message: alert.message,
                          dismissButton: alert.dismissButton)
                }
            } //VStack ends
            .navigationTitle("Registration")
            .navigationBarTitleDisplayMode(.inline)

        } // zstack
    }
}

#Preview {
    @State var rootScreen : RootView = .SignUp
    
    return SignUpView(rootScreen: $rootScreen)
}

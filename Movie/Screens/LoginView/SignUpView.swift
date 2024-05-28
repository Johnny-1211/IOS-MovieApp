import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @Binding var rootScreen : RootView
    
    @State private var userName : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State private var createAccount = false
    @State private var showAlert = false
    @State private var alertCategory = ""
    
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
                            if self.password.count >= 6{
                                if (self.password == self.confirmPassword){
                                    self.fireAuthHelper.signUp(userName: userName, email: email, password: password, showAlert: $showAlert, rootScreen: $rootScreen, alertCategory: $alertCategory)
                                } else{
                                    alertCategory = "invaildRegistration"
                                    showAlert = true
                                }
                            }else{
                                print(#function, "password must be 6 characters long or more")
                            }
                        }else{
                            alertCategory = "emptyField"
                            showAlert = true
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
                .alert(isPresented: $showAlert) {
                    switch alertCategory {
                    case "registrateSuccess":
                        return Alert(title: AlertContext.registrateSuccess.title,
                                     message: AlertContext.registrateSuccess.message,
                                     dismissButton: AlertContext.registrateSuccess.dismissButton)
                        
                    case "invaildRegistration":
                        return Alert(title: AlertContext.invaildRegistration.title,
                                     message: AlertContext.invaildRegistration.message,
                                     dismissButton: AlertContext.invaildRegistration.dismissButton)
                        
                    case "emptyField":
                        return Alert(title: AlertContext.emptyField.title,
                                     message: AlertContext.emptyField.message,
                                     dismissButton: AlertContext.emptyField.dismissButton)
                    default:
                        return Alert(title: Text(""), message: nil)
                    }
                }
                .padding(.horizontal,20)
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

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var rootScreen : RootView
    
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var showAlert = false
    @State private var alertCategory = ""
    
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            VStack{
                VStack(spacing: 10){
                    Text("Sign in to SuperMovie")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color("lightButton"))
                        .font(.title2.bold())
                    
                    VStack(alignment: .leading){
                        Text("Email")
                            .foregroundStyle(.white)
                        TextField("Your email address", text: self.$email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                        
                        
                        Text("Password")
                            .foregroundStyle(.white)
                        SecureField("Enter your password", text: self.$password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                        Button(action: {
                            if (!self.email.isEmpty && !self.password.isEmpty){
                                self.fireAuthHelper.signIn(email: self.email, password: self.password, rootScreen: $rootScreen)
                            }else{
                                self.showAlert = true
                                alertCategory = "invaildLogin"
                                print(#function, "email and password cannot be empty")
                            }
                        }){
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .font(.body.bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.vertical, 10)
                        
                        LabelledDivider(label: "OR")
                    }
                    .alert(isPresented: $showAlert) {
                        switch alertCategory {
                        case "invaildLogin":
                            return Alert(title: AlertContext.invaildLogin.title,
                                         message: AlertContext.invaildLogin.message,
                                         dismissButton: AlertContext.invaildLogin.dismissButton)
                        default:
                            return Alert(title: Text(""), message: nil)
                        }
                    }
                    .padding(.horizontal,20)
                    HStack{
                        Text("Don't have an account?")
                            .foregroundStyle(.gray)
                        Button(action: {
                            self.rootScreen = .SignUp
                        }){
                            Text("Sign Up")
                                .font(.body.bold())
                                .foregroundColor(Color("lightButton"))
                            
                        }
                    }
                }
            } //VStack ends
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear{
                self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                self.password = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
            }
            
        } // zstack
    }
}

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var rootScreen : RootView
    
    @State private var email : String = ""
    @State private var password : String = ""
    
    
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
                            //validate the data
                            if (!self.email.isEmpty && !self.password.isEmpty){
                                
                                //validate credentials
                                self.fireAuthHelper.signIn(email: self.email, password: self.password)
                                self.fireDBHelper.getAllMovies()
                                
                                //navigate to home screen
                                self.rootScreen = .Home
                            }else{
                                //trigger alert displaying errors
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
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                self.password = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
            }
        } // zstack
        
        
        
        
    }
}

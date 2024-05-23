import Foundation
import SwiftUI
import FirebaseAuth

class FireAuthHelper : ObservableObject {
    private let fireDBHelper = FireDBHelper.getInstance()
    
    @Published var user : User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            guard let self = self else{
                return
            }
            self.user = user
        }
    }
    
    func signUp(userName : String, email : String, password : String, showAlert: Binding<Bool>, rootScreen: Binding<RootView>, alertCategory:Binding<String>){
        
        Auth.auth().createUser(withEmail: email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while creating account : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = authResult?.user
                fireDBHelper.createUser(userID: user!.uid, name: userName, email: email)
                alertCategory.wrappedValue = "registrateSuccess"
                showAlert.wrappedValue = true
                rootScreen.wrappedValue = .Home
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
    }
    
    func signIn(email : String, password : String, rootScreen: Binding<RootView>){
        
        Auth.auth().signIn(withEmail: email, password: password){ [self] authResult, error in
            guard let result = authResult else{
                print(#function, "Error while logging in : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to sign in")
                return
            case .some(_):
                print(#function, "Login Successful")
                self.user = authResult?.user
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
                rootScreen.wrappedValue = .Home
                
            }
        }
        
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch let err as NSError{
            print(#function, "Unable to sign out the user : \(err)")
        }
    }
    
    func updatePassword(password:String, showingAlert: Binding<Bool> ,alertMessage: Binding<String>){
        guard let currentUser = Auth.auth().currentUser else {
            print(#function, "No user is currently signed in")
            return
        }
        do{
            currentUser.updatePassword(to: password)
            showingAlert.wrappedValue = true
            alertMessage.wrappedValue = "Update successfully"
        }catch let err as NSError{
            showingAlert.wrappedValue = true
            alertMessage.wrappedValue = "Update password failure"
            print(#function, "Update password failure: \(err)")
        }
        
    }
    
    func reAuthenticateUserAndUpdate(updateType: String, updateData: String, showingAlert: Binding<Bool> ,alertMessage: Binding<String>) {
        guard let currentUser = Auth.auth().currentUser else {
            print(#function, "No user is currently signed in")
            return
        }
        
        let currentEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        let currentPassword = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
        let credential = EmailAuthProvider.credential(withEmail: currentEmail, password: currentPassword)
        
        currentUser.reauthenticate(with: credential) { result, error in
            if let error = error {
                showingAlert.wrappedValue = true
                alertMessage.wrappedValue = "Error reauthenticating"
                print("Error reauthenticating: \(error.localizedDescription)")
            }else{
                print("Successfully authenicate the user")
                switch updateType{
                case "email":
                    do{
                        currentUser.sendEmailVerification(beforeUpdatingEmail: updateData) { error in
                            if let error = error {
                                showingAlert.wrappedValue = true
                                alertMessage.wrappedValue = "Unable to send email verification"
                                print(#function, "Unable to send email verification: \(error.localizedDescription)")
                            }else{
                                self.fireDBHelper.updateEmail(email: updateData)
                                showingAlert.wrappedValue = true
                                alertMessage.wrappedValue = "verification link of email update sent!"
                                print(#function, "Update successfully")
                            }
                        }
                        
                    }catch let err as NSError{
                        showingAlert.wrappedValue = true
                        alertMessage.wrappedValue = "Update email failure"
                        print(#function, "Update email failure: \(err)")
                    }
                case "password":
                    do{
                        currentUser.updatePassword(to: updateData)
                        showingAlert.wrappedValue = true
                        alertMessage.wrappedValue = "Update successfully"
                    }catch let err as NSError{
                        showingAlert.wrappedValue = true
                        alertMessage.wrappedValue = "Update password failure"
                        print(#function, "Update password failure: \(err)")
                    }
                default:
                    print(#function, "No updateType")
                }
            }
        }
    }
}

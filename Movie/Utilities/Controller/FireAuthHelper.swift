import Foundation
import SwiftUI
import FirebaseAuth

class FireAuthHelper : ObservableObject {
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
    
    func signUp(userName : String, email : String, password : String){
        
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
                
                guard let uid = authResult?.user.uid else {return}
                let data: [String: Any] = [
                    "uid": uid,
                    "email": email,
                    "username": userName]
                
//                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
//                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
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
                
                print(#function, "Logged in user : \(self.user?.displayName ?? "NA" )")
                
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
    
    func updateProfile(newName: String) {
        
    }
}

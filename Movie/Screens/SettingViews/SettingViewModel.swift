
import SwiftUI

class SettingViewModel: ObservableObject {
//    @Published var oldName : String = ""
//    @Published var oldEmail : String = ""
    @Published var userName : String = ""
    @Published var newEmail : String = ""
    @Published var newPassword : String = ""
    @Published var showingAlert: Bool = false
    
    @Published var nameError : String?
    @Published var emailError : String?
    @Published var passwordError : String?
        
//    func validateAndSubmit(currentEmail currentEmail: String) {
//        // Clear previous errors
//        emailError = nil
//        passwordError = nil
//        print("emailError: \(emailError)")
//        print("passwordError: \(passwordError)")
//        // Validate current email
//        if currentEmail.isEmpty {
//            emailError = "Current email is required."
//        } else if !isValidEmail(currentEmail) {
//            emailError = "Invalid email format."
//        }
//        
//        // Validate current password
//        if currentPassword.isEmpty {
//            passwordError = "Current password is required."
//        } else if currentPassword.count < 6 {
//            passwordError = "Password must be at least 6 characters long."
//        }
//        
//    }
//    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    

}

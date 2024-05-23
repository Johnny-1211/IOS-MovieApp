
import SwiftUI

class SettingViewModel: ObservableObject {
//    @Published var oldName : String = ""
//    @Published var oldEmail : String = ""
    @Published var userName : String = ""
    @Published var newEmail : String = ""
    @Published var newPassword : String = ""
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var nameError : String?
    @Published var emailError : String?
    @Published var passwordError : String?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    

}

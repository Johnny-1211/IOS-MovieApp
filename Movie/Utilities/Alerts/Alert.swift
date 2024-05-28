import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: - Network Alerts
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                            message: Text("The data received from the server was invalid. Please contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                            message: Text("Invalid response from the server. Please try again later or contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItem(title: Text("Sever Error"),
                                            message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("OK")))
    
    //MARK: - Login / Sign Up Alert
    static let emptyField = AlertItem(title: Text("Invaild Input"),
                                       message: Text("Please fill in all the required fields."),
                                       dismissButton: .default(Text("OK")))
    
    static let invaildLogin = AlertItem(title: Text("Invaild Login"),
                                       message: Text("Username or password is incorrect. Please try again."),
                                       dismissButton: .default(Text("OK")))
    
    static let invaildRegistration = AlertItem(title: Text("Invalid Registration"),
                                               message: Text("Please make sure your password and confirm password match, and all fields are filled."),
                                               dismissButton: .default(Text("OK")))
    
    static let registrateSuccess = AlertItem(title: Text("Success"),
                                               message: Text("Your account has been created successfully."),
                                               dismissButton: .default(Text("OK")))
    static let loginSuccess = AlertItem(title: Text("Success"),
                                               message: Text("Your account has been login successfully."),
                                               dismissButton: .default(Text("OK")))
    
}

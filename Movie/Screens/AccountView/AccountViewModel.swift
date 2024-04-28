
import SwiftUI

final class AccountViewModel: ObservableObject {
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    

}

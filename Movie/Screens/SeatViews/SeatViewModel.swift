import Foundation
import SwiftUI

class SeatViewModel : ObservableObject {
    @Published var randomNum:String = ""
    @Published var showPopup = false
    @Published var price = 10
    
    @Published var date: TicketDate = TicketDate.default
    @Published var hour: String = ""
    @Published var navigateToOrderSummary = false
    @Published var isSelectable: Bool = true
    @Published var dateSelected: Bool = false
    @Published var hourSelected: Bool = false
    

    func generateRandomNumber(){
        var result = ""
        for _ in 0..<8 {
            let digit = arc4random_uniform(10)
            result += "\(digit)"
        }
        randomNum = result
        print(randomNum)
    }
}

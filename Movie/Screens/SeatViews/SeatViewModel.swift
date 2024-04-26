import Foundation
import SwiftUI

class SeatViewModel : ObservableObject {
    @Published var randomNum:String = ""
    @Published var showPopup = false
    @Published var price = 10
//
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

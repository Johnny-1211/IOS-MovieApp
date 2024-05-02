import Foundation
import FirebaseFirestoreSwift


struct MovieOrder : Codable {
    @DocumentID var id : String? = UUID().uuidString
    var title : String
    var orderNum : String
    var date : String
    var hour : String
    var selectedSeats : [Seat]
    var cinema : String
    var ticketPrice: Int
}

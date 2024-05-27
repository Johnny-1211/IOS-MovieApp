import Foundation
import FirebaseFirestoreSwift

struct BookedChair: Codable, Hashable, Identifiable{
    @DocumentID var id : String? = UUID().uuidString
    var title : String
    var cinema : String
    var date : String
    var hour : String
    var selectedSeats : [Seat]
}

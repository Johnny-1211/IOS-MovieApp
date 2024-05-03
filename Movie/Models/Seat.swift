import Foundation

struct Seat: Codable, Identifiable, Hashable {
    var id: UUID
//    var row: String
//    var number: Int
    var seatNum:String
    
    static var `default`: Seat {
//        Seat(id: UUID(), row: "", number: 0)
    Seat(id: UUID(), seatNum: "")

    }
}

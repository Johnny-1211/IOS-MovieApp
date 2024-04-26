import Foundation

struct Seat: Identifiable {
    var id: UUID
    var row: String
    var number: Int
    
    static var `default`: Seat {
        Seat(id: UUID(), row: "", number: 0)
    }
}

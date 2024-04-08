import Foundation

struct Seat: Identifiable {
    var id: UUID
    var row: Int
    var number: Int
    
    static var `default`: Seat {
        Seat(id: UUID(), row: 0, number: 0)
    }
}

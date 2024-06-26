import Foundation

struct TicketDate : Codable,Equatable, Hashable {
    var day: String
    var month: String
    var year: String
    static var `default`: TicketDate {
        TicketDate(day: "", month: "", year: "")
    }
}

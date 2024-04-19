import Foundation

struct Movie : Codable{
    var adult : Bool
    var id : Int
    var original_language : String
    var overview : String
    var title : String
    var vote_average : Double
}

import Foundation

struct Movie : Codable, Hashable{
    var adult : Bool
    var id : Int
    var original_language : String
    var overview : String
    var poster_path : String
    var release_date:String
    var title : String
    var vote_average : Double
}

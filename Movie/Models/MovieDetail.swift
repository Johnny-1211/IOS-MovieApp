import Foundation

struct MovieDetail : Codable, Hashable{
    var id : Int
    var backdrop_path : String
    var homepage: String
    var original_language : String
    var overview : String
    var poster_path : String
    var release_date:String
    var runtime: Int
    var status: String
    var title : String
    var vote_average : Double
}

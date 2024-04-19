import Foundation
import UIKit

//api : ef5aaeb8cc3a509e9fa0d309bcde2999

final class NetworkManager {
    static let shared = NetworkManager()
    
    static let apiKey = "ef5aaeb8cc3a509e9fa0d309bcde2999"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    private let nowplayingMovie = baseURL + "now_playing" + "?api_key=\(apiKey)"
    
    private init() {}
    
    func getNowPlayingMovie() async throws -> Movies {
        guard let url = URL(string: nowplayingMovie) else {
            throw MOError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Movies.self, from: data)
        } catch {
            throw MOError.invalidData
        }
    }
    
}

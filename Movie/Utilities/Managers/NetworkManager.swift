import Foundation
import UIKit

//api : ef5aaeb8cc3a509e9fa0d309bcde2999

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "ef5aaeb8cc3a509e9fa0d309bcde2999"
    var movieID : Int = 0
    
    private let nowplayingMovie = baseURL + "now_playing" + "?api_key=\(apiKey)"
    private let upcomingMovie = baseURL + "upcoming" + "?api_key=\(apiKey)"
    private var movieDetail : String {
        return "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(NetworkManager.apiKey)"
    }
    
    private var movieCredit : String {
        return "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(NetworkManager.apiKey)"
    }
    
    
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
            print(error)
            throw MOError.invalidData
        }
    }
    
    func getUpComingMovie() async throws -> Movies {
        guard let url = URL(string: upcomingMovie) else {
            throw MOError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Movies.self, from: data)
        } catch {
            print(error)
            throw MOError.invalidData
        }
    }
    
    func getMovieDetail(movieID:Int) async throws -> MovieDetail {
        self.movieID = movieID
        guard let url = URL(string: movieDetail) else {
            throw MOError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieDetail.self, from: data)
        } catch {
            print(error)
            throw MOError.invalidData
        }
    }
    
    func getMovieCredit(movieID:Int) async throws -> Credit {
        self.movieID = movieID
        guard let url = URL(string: movieCredit) else {
            throw MOError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Credit.self, from: data)
        } catch {
            print(error)
            throw MOError.invalidData
        }
    }
    
}

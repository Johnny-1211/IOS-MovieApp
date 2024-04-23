import Foundation
import SwiftUI

@MainActor final class HomeViewModel : ObservableObject{
    @Published var alertItem : AlertItem?
    @Published var nowplayingMovie : [Movie] = []
    @Published var upcomingMovie : [Movie] = []
    
    func getNowPlayingMovie(){
        Task{
            do{
                let nowPlayingMovies = try await NetworkManager.shared.getNowPlayingMovie()
                let upComingMovies = try await NetworkManager.shared.getUpComingMovie()
                nowplayingMovie = nowPlayingMovies.results
                upcomingMovie  = upComingMovies.results
            }catch{
                if let moError = error as? MOError{
                    switch moError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
            }
        }
    }
    
}

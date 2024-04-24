import Foundation
import SwiftUI

@MainActor final class DetailViewModel : ObservableObject{
    @Published var alertItem : AlertItem?
    @Published var movieDetail : MovieDetail?
    @Published var movieCast : [Cast] = []
    
    func getMovieDetail(movieID : Int){
        Task{
            do{
                movieDetail = try await NetworkManager.shared.getMovieDetail(movieID: movieID)
                movieCast = try await NetworkManager.shared.getMovieCredit(movieID: movieID).cast
                
                
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

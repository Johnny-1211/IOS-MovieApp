import Foundation
import SwiftUI

@MainActor final class DetailViewModel : ObservableObject{
    @Published var alertItem : AlertItem?
    @Published var movieDetail : MovieDetail?
    
    func getMovieDetail(movieID : Int){
        Task{
            do{
                movieDetail = try await NetworkManager.shared.getMovieDetail(movieID: movieID)
                print("movieDetail: \(movieDetail)")
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

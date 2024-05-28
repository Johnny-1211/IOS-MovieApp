import Foundation
import SwiftUI

@MainActor final class DetailViewModel : ObservableObject{
    @Published var alertItem : AlertItem?
    @Published var movieDetail : MovieDetail?
    @Published var movieCast : [Cast] = []
    @Published var cinema = ["Cineplex Cinemas Yorkdale",
                            "The Royal","Cineplex Entertainment"]
    @Published var cinemaAddress = ["3401 Dufferin St, Toronto, ON M6A 2T9",
                                    "608 College St, Toronto, ON M6G 1B4",
                                    "1303 Yonge St, Toronto, ON M4T 2Y9"]
    @Published var selectedItemIndex: Int? = nil
    @Published var selectedCinema = ""
    @Published var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @Published var gradient = [Color.black.opacity(0),Color.black,Color.black,Color.black]


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

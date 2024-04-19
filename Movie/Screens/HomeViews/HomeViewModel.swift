import Foundation
import SwiftUI

@MainActor final class HomeViewModel : ObservableObject{
    
    @Published var alertItem : AlertItem?
    @Published var movies : Movies?
    
    func getNowPlayingMovie(){
        Task{
            do{
                movies = try await NetworkManager.shared.getNowPlayingMovie()
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

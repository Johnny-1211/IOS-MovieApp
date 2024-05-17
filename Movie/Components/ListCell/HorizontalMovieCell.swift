import SwiftUI

struct HorizontalMovieCell: View {
    let imageBaseUrl: String
    let movie: Movie
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imageBaseUrl + movie.poster_path)) { image in
                image
                    .image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
                    .cornerRadius(12)
                    .scrollTransition(.animated){ content, phase in
                        content
                            .scaleEffect(phase != .identity ? 0.8 : 1)
                            .opacity(phase != .identity ? 0.3 : 1)
                    }
            }
            
            Text(movie.title)
                .font(.body.bold())
                .foregroundStyle(.white)
                .frame(width: 180)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    
    return
    ZStack{
        Color("background")
            .ignoresSafeArea()
        HorizontalMovieCell(imageBaseUrl: imageBaseUrl, movie: Movie(adult: false,
                                                                     id: 693314,
                                                                     original_language: "en",
                                                                     overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
                                                                     poster_path: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
                                                                     release_date: "2024-02-27",
                                                                     title: "Godzilla x Kong: The New Empire",
                                                                     vote_average: 8.299))
    }
}

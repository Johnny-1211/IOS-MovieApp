import SwiftUI

struct VerticalMovieCell: View {
    let imageBaseUrl:String
    let movie:Movie
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: imageBaseUrl + movie.poster_path)){ image in
                image
                    .image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
            
            VStack(alignment: .leading,spacing: 10){
                Text(movie.title)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                
                Text("Overview: \(movie.overview)")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .lineLimit(4)
                
                Text("Language: \(movie.original_language.uppercased())")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                
                Text("Rating: \(String(format: "%.2f", movie.vote_average))")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    
    return 
    ZStack{
        Color("background")
            .ignoresSafeArea()
        VerticalMovieCell(imageBaseUrl: imageBaseUrl, movie: Movie(adult: false,
                                                                   id: 693314,
                                                                   original_language: "en",
                                                                   overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
                                                                   poster_path: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
                                                                   release_date: "2024-02-27",
                                                                   title: "Dune: Part Two",
                                                                   vote_average: 8.299))
    }
}

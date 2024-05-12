import SwiftUI

struct UpcomingMovieCell: View {
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
                
                Text("Rating: \(String(format: "%.2f", movie.vote_average))")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

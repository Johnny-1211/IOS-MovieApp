import SwiftUI

struct NowPlayingMovieCell: View {
    let imageBaseUrl:String
    let movie:Movie
    
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
        }
    }
}

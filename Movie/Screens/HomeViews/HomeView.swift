import SwiftUI

struct HomeView: View {
    
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @State private var nowPlayingMovie = ["thor","dune","CivilWar"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                NavigationStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Welcome Johnny👋")
                                .font(.body)
                                .foregroundStyle(.gray)
                            
                            Text("Let's relax and watch a movie.")
                                .font(.body.bold())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        //                        Rectangle()
                        //                            .frame(width: 50, height: 50)
                        //                            .foregroundStyle(.white)
                        //                            .cornerRadius(12)
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        HStack{
                            Text("Now Playing")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Text("See All")
                                    .foregroundStyle(.yellow)
                            })
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20){
                                ForEach(viewModel.nowplayingMovie, id: \.self){ movie in
                                    NavigationLink {
                                        DetailView(movieID: movie.id)
                                    } label: {
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
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .scrollClipDisabled(true)
                        
                        HStack{
                            Text("Coming soon")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Text("See All")
                                    .foregroundStyle(.yellow)
                            })
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        
                        ScrollView{
                            VStack{
                                ForEach(viewModel.upcomingMovie, id: \.self){ movie in
                                    Section {
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
                                    .background(Color("SectionColor"))
                                    .cornerRadius(12)
                                }
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                }
            }
            
        }
        .task {
            viewModel.getNowPlayingMovie()
        }
    }
}
#Preview {
    HomeView()
}

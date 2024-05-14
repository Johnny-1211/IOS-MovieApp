import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    @State private var isShowingDetail = false
    
    var body: some View {    
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Welcome \(Auth.auth().currentUser?.displayName ?? "Guest")👋")
                                .font(.body)
                                .foregroundStyle(.gray)
                            
                            Text("Let's relax and watch a movie.")
                                .font(.body.bold())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        HStack{
                            Text("Now Playing")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20){
                                ForEach(viewModel.nowplayingMovie, id: \.self){ movie in
                                    Button{
                                        isShowingDetail = true
                                    } label:{
                                        NowPlayingMovieCell(imageBaseUrl: imageBaseUrl, movie: movie)
                                    }
                                    .fullScreenCover(isPresented: $isShowingDetail) {
                                        DetailView(dismissSheet: $isShowingDetail, movieID: movie.id)
                                            .environmentObject(fireDBHelper)
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
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        
                        ScrollView{
                            VStack{
                                ForEach(viewModel.upcomingMovie, id: \.self){ movie in
                                    Section {
                                        UpcomingMovieCell(imageBaseUrl: imageBaseUrl, movie: movie)
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

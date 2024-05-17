import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @State private var isShowingDetail = false
    @State private var searchText: String = ""
    @State private var activeTab: Tab = .all
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    //                    HStack{
                    //                        VStack(alignment: .leading){
                    //                            Text("Welcome \(Auth.auth().currentUser?.displayName ?? "Guest")👋")
                    //                                .font(.body)
                    //                                .foregroundStyle(.gray)
                    //
                    //                            Text("Let's relax and watch a movie.")
                    //                                .font(.body.bold())
                    //                                .foregroundStyle(.white)
                    //                        }
                    //                        Spacer()
                    //                    }
                    //                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack{
                            HStack{
                                Text("Now Playing")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20){
                                    ForEach(viewModel.nowplayingMovie.filter{$0.title.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""}, id: \.self) { movie in
                                        
                                        NowPlayingMovieCell(imageBaseUrl: imageBaseUrl, movie: movie)
                                            .onTapGesture {
                                                isShowingDetail = true
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
                                    ForEach(viewModel.upcomingMovie.filter{$0.title.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""}, id: \.self){ movie in
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
                        .safeAreaInset(edge: .top, spacing: 0) {
                            ExpandableNavigationBar(searchText: $searchText, activeTab: $activeTab, title: "Movies")
                        }
                    }
                    .scrollTargetBehavior(CustomScrollTargetBehaviour())

                }
            }
            
        }
        .task {
            viewModel.getNowPlayingMovie()
        }
    }
}

#Preview {
    let fireDBHelper = FireDBHelper.getInstance()
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @State var isShowingDetail = false
    
    return HomeView(imageBaseUrl: imageBaseUrl, viewModel: viewModel).environmentObject(fireDBHelper)
    
}


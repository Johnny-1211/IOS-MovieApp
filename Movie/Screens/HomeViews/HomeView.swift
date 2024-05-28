import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @State private var isShowingDetail = false
    @State private var searchText: String = ""
    @State private var activeTab: Tab = .all
    @State private var selectedMovieID : IdentifiableInt?
    
    @Binding var rootScreen : RootView
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack{
                            switch activeTab {
                            case .all:
                                HStack{
                                    Text("Now Playing")
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20){
                                        ForEach(viewModel.nowplayingMovie.filter{$0.title.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""}, id: \.self) { nowplayingMovie in
                                            Button{
                                                selectedMovieID = IdentifiableInt(id: nowplayingMovie.id)
                                                isShowingDetail = true
                                            } label: {
                                                HorizontalMovieCell(imageBaseUrl: imageBaseUrl, movie: nowplayingMovie)
                                            }
                                            .fullScreenCover(item: $selectedMovieID, onDismiss: {
                                                selectedMovieID = nil
                                                isShowingDetail = false
                                            }) { identifiableInt in
                                                DetailView(dismissSheet: $isShowingDetail, selectedMovieID: $selectedMovieID ,movieID: identifiableInt.id)
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
                                                VerticalMovieCell(imageBaseUrl: imageBaseUrl, movie: movie)
                                            }
                                            .background(Color("SectionColor"))
                                            .cornerRadius(12)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            case .nowPlaying:
                                HStack{
                                    Text("Now Playing")
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                                
                                ScrollView{
                                    VStack{
                                        ForEach(viewModel.nowplayingMovie.filter{$0.title.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""}, id: \.self){ nowplayingMovie in
                                            Section {
                                                Button{
                                                    selectedMovieID = IdentifiableInt(id: nowplayingMovie.id)
                                                    isShowingDetail = true
                                                } label: {
                                                    VerticalMovieCell(imageBaseUrl: imageBaseUrl, movie: nowplayingMovie)
                                                }
                                                .fullScreenCover(item: $selectedMovieID, onDismiss: {
                                                    selectedMovieID = nil
                                                    isShowingDetail = false
                                                }) { identifiableInt in
                                                    DetailView(dismissSheet: $isShowingDetail, selectedMovieID: $selectedMovieID ,movieID: identifiableInt.id)
                                                        .environmentObject(fireDBHelper)
                                                }
                                            }
                                            .background(Color("SectionColor"))
                                            .cornerRadius(12)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                
                            case .upcoming:
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
                                                VerticalMovieCell(imageBaseUrl: imageBaseUrl, movie: movie)
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
                        .safeAreaInset(edge: .top, spacing: 0) {
                            ExpandableNavigationBar(searchText: $searchText, activeTab: $activeTab, title: "Movies")
                        }
                    }
                    .scrollTargetBehavior(CustomScrollTargetBehaviour())
                    
                }
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: alertItem.dismissButton)
                }
            }
            
        }
        .task {
            if rootScreen == .Home{
                fireDBHelper.getAllMovies()
                viewModel.getNowPlayingMovie()
            }
        }
    }
}

#Preview {
    let fireDBHelper = FireDBHelper.getInstance()
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = HomeViewModel()
    @State var isShowingDetail = false
    @State var rootScreen : RootView = .Home
    
    return HomeView(imageBaseUrl: imageBaseUrl, viewModel: viewModel, rootScreen: $rootScreen).environmentObject(fireDBHelper)
    
}


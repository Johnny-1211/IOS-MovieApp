
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = DetailViewModel()
    @Binding var dismissSheet : Bool
    @Binding var selectedMovieID: IdentifiableInt?

    var movieID : Int = 0
        
    var body: some View {
        NavigationStack{
            ZStack{
                if let movie = viewModel.movieDetail{
                    AsyncImage(url: URL(string: viewModel.imageBaseUrl + (movie.backdrop_path))) { image in
                        image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    VStack{
                        LinearGradient(colors: viewModel.gradient, startPoint: .top, endPoint: .bottom)
                            .frame(height: 750)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
                    VStack(spacing:0.0){
                        HStack{
                            Circle()
                                .fill(.gray)
                                .frame(width: 45)
                                .foregroundStyle(.white)
                                .overlay{
                                    Button{
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(systemName: "multiply")
                                            .foregroundStyle(.white)
                                    }
                                }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 46, leading: 20, bottom: 0, trailing: 20))
                        
                        
                        Rectangle()
                            .fill(Color("SectionColor"))
                            .frame(width: 340,height: 180)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                            .overlay{
                                VStack(alignment:.leading, spacing: 25){
                                    HStack{
                                        Text("Movie Name: \(movie.title)")
                                            .font(.title3.bold())
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                    
                                    Text("Date: \(movie.release_date)")
                                        .font(.body)
                                        .foregroundStyle(.gray)
                                    Text("Run Time: \(movie.runtime)m")
                                        .font(.body)
                                        .foregroundStyle(.gray)
                                }
                                .padding(EdgeInsets(top: 60, leading: 20, bottom: 0, trailing: 20))
                            }
                        
                        HStack{
                            ScrollView(.vertical){
                                VStack(alignment: .leading){
                                    Text("Description")
                                        .font(.title3.bold())
                                        .foregroundStyle(.white)

                                    
                                    
                                    Text(movie.overview)
                                        .frame(width: 300, height: 100)
                                        .font(.body)
                                        .foregroundStyle(.gray)
                                    
                                    Text("Cast")
                                        .font(.title3.bold())
                                        .foregroundStyle(.white)
                                    
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 10){
                                            ForEach(viewModel.movieCast, id: \.self){ cast in
                                                Section{
                                                    HStack{
                                                        if let profile = cast.profile_path {
                                                            AsyncImage(url: URL(string: viewModel.imageBaseUrl + (profile))) { image in
                                                                image
                                                                    .image?.resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                                                    .scrollTransition(.animated){ content, phase in
                                                                        content
                                                                            .scaleEffect(phase != .identity ? 0.8 : 1)
                                                                            .opacity(phase != .identity ? 0.3 : 1)
                                                                    }
                                                            }
                                                        }else{
                                                            Image(systemName: "person.slash.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                                .scrollTransition(.animated){ content, phase in
                                                                    content
                                                                        .scaleEffect(phase != .identity ? 0.8 : 1)
                                                                        .opacity(phase != .identity ? 0.3 : 1)
                                                                }
                                                        }
                                                        
                                                        Spacer()
                                                        VStack(alignment: .leading, spacing: 10){
                                                            Text("Name: \(cast.name)")
                                                                .font(.system(size: 12))
                                                                .foregroundStyle(.white)
                                                            Text("Character: \(cast.character)")
                                                                .font(.system(size: 12))
                                                                .foregroundStyle(.white)
                                                        }
                                                        Spacer()
                                                    }
                                                }
                                                .frame(width: 220, height: 75)
                                                .background(Color("SectionColor"))
                                                .cornerRadius(12)
                                            }
                                        }
                                    }
                                    
                                    Text("Cinema")
                                        .font(.title3.bold())
                                        .foregroundStyle(.white)
                                    ScrollView(.vertical){
                                        VStack(alignment:.leading){
                                            ForEach(viewModel.cinema.indices, id: \.self){ index in
                                                VStack(alignment:.leading){
                                                    Text(viewModel.cinema[index])
                                                        .font(.body.bold())
                                                        .foregroundStyle(.white)
                                                    
                                                    Text(viewModel.cinemaAddress[index])
                                                        .font(.body)
                                                        .foregroundStyle(.gray)
                                                }
                                                .frame(height: 60)
                                                .frame(maxWidth: .infinity,
                                                       alignment: .leading)
                                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                                .background(viewModel.selectedItemIndex == index ? Color.yellow.opacity(0.3) : Color("SectionColor"))
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(viewModel.selectedItemIndex == index ? Color.yellow : Color("SectionColor"), lineWidth: 4)
                                                }
                                                .onTapGesture {
                                                    viewModel.selectedItemIndex = index
                                                    viewModel.selectedCinema = viewModel.cinema[index]
                                                }
                                            }
                                            .cornerRadius(12)
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 20))
                            }
                        }
                        
                        NavigationLink{
                            SeatChoiceView(dismissSheet: $dismissSheet, selectedMovieID: $selectedMovieID ,movieDetail: movie, cinema: viewModel.selectedCinema)
                        } label: {
                            ConfirmBtn(text: "Book Now", width: 250, height: 50, top: 10, leading: 0, bottom: 20, trailing: 0)
                        }
                        .environmentObject(fireDBHelper)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }else{
                    Text("Loading...")
                        .onAppear{
                            viewModel.getMovieDetail(movieID: movieID)
                        }
                }
                    
            }
            .background(.black)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear{
                viewModel.selectedItemIndex = nil
                viewModel.selectedCinema = ""
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
            
        }
    }
}




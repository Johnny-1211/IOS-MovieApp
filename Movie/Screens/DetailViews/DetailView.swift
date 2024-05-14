
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.presentationMode) var presentationMode

    @State private var cinema = ["Cineplex Cinemas Yorkdale",
                                 "The Royal","Cineplex Entertainment"]
    @State private var cinemaAddress = ["3401 Dufferin St, Toronto, ON M6A 2T9",
                                        "608 College St, Toronto, ON M6G 1B4",
                                        "1303 Yonge St, Toronto, ON M4T 2Y9"]
    @State private var selectedItemIndex: Int? = nil
    @State private var selectedCinema = ""
    @State private var gradient = [Color.black.opacity(0),Color.black,Color.black,Color.black]
    
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @StateObject var viewModel = DetailViewModel()
    
    @Binding var dismissSheet : Bool
    

    var movieID : Int = 0
        
    var body: some View {
        NavigationStack{
            ZStack{
                if let movie = viewModel.movieDetail{
                    AsyncImage(url: URL(string: imageBaseUrl + (movie.backdrop_path))) { image in
                        image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    VStack{
                        LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
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
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "bookmark.circle")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 30))
                                        })
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
                                                            AsyncImage(url: URL(string: imageBaseUrl + (profile))) { image in
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
                                            ForEach(cinema.indices, id: \.self){ index in
                                                VStack(alignment:.leading){
                                                    Text(cinema[index])
                                                        .font(.body.bold())
                                                        .foregroundStyle(.white)
                                                    
                                                    Text(cinemaAddress[index])
                                                        .font(.body)
                                                        .foregroundStyle(.gray)
                                                }
                                                .frame(height: 60)
                                                .frame(maxWidth: .infinity,
                                                       alignment: .leading)
                                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                                .background(self.selectedItemIndex == index ? Color.yellow.opacity(0.3) : Color("SectionColor"))
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(self.selectedItemIndex == index ? Color.yellow : Color("SectionColor"), lineWidth: 4)
                                                }
                                                .onTapGesture {
                                                    selectedItemIndex = index
                                                    selectedCinema = cinema[index]
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
                            SeatChoiceView(movieDetail: movie, cinema: selectedCinema, dismissSheet: $dismissSheet)
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

        }
    }
}




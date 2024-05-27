
import SwiftUI

struct SeatChoiceView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var dismissSheet : Bool
    @Binding var selectedMovieID: IdentifiableInt?

    @State private var selectedSeats: [Seat] = []
    
    private var areBothTrue: Bool {
        viewModel.dateSelected && viewModel.hourSelected
    }
    
    @StateObject var viewModel = SeatViewModel()
    var movieDetail: MovieDetail?
    var cinema:String
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0.0){
                HStack{
                    BackBtn()
                    Spacer()
                }
                .padding(.horizontal, 20)
                if areBothTrue{
                    Theatre(selectedSeats: $selectedSeats)
                    
                }else{
                    VStack{
                        Spacer()
                        Image(systemName: "rectangle.inset.filled.and.person.filled")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Text("Please select the date and hour first")
                        Spacer()
                    }
                }
                DateTimeView(movieTitle: movieDetail!.title, cinema: cinema, date: self.$viewModel.date, hour: self.$viewModel.hour, dateSelected: $viewModel.dateSelected, hourSelected: $viewModel.hourSelected)
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Price")
                            .foregroundStyle(.gray)
                        Text("$\(selectedSeats.count * viewModel.price)")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(isActive: $viewModel.navigateToOrderSummary){
                        OrderSummaryView(dismissSheet: $dismissSheet,
                                         selectedMovieID: $selectedMovieID,
                                         ticketPrice: viewModel.price,
                                         orderNum: viewModel.randomNum,
                                         movieDetail: movieDetail,
                                         date: viewModel.date,
                                         hour: viewModel.hour,
                                         selectedSeats: selectedSeats,
                                         cinema: cinema)
                        .environmentObject(fireDBHelper)
                    } label: {
                        Button{
                            viewModel.generateRandomNumber()
                            viewModel.navigateToOrderSummary = true
                        }label: {
                            ConfirmBtn(text: "Buy Ticket", width: 200, height: 60, top: 10, leading: 10, bottom: 10, trailing: 10)
                        }
                    }
                }
                .padding(20)
                
            }
            .background(.black)
            .navigationBarBackButtonHidden(true)
            .onChange(of: viewModel.date, {
                if areBothTrue{
                    Task{
                        let date = "\(viewModel.date.day)-\(viewModel.date.month)-\(viewModel.date.year)"
                        await fireDBHelper.getUnavailableChair(movieTitle: movieDetail!.title, cinema: cinema, date: date, hour: viewModel.hour)
                    }
                }else{
                    print("waiting for both conditions to be true")
                }
            })
            .onChange(of: viewModel.hour, {
                if areBothTrue{
                    Task{
                        let date = "\(viewModel.date.day)-\(viewModel.date.month)-\(viewModel.date.year)"
                        await fireDBHelper.getUnavailableChair(movieTitle: movieDetail!.title, cinema: cinema, date: date, hour: viewModel.hour)
                    }
                }else{
                    print("waiting for both conditions to be true")
                }
            })
        }
    }
}


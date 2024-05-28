
import SwiftUI

struct SeatChoiceView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var dismissSheet : Bool
    @Binding var selectedMovieID: IdentifiableInt?
    @StateObject var viewModel = SeatViewModel()
    
    private var allSelected: Bool {
        !viewModel.selectedSeats.isEmpty && viewModel.dateSelected && viewModel.hourSelected
    }
    
    private var dateHourBothTrue: Bool {
        viewModel.dateSelected && viewModel.hourSelected
    }
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
                if dateHourBothTrue{
                    Theatre(selectedSeats: $viewModel.selectedSeats)
                    
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
                        Text("$\(viewModel.selectedSeats.count * viewModel.price)")
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
                                         selectedSeats: viewModel.selectedSeats,
                                         cinema: cinema)
                        .environmentObject(fireDBHelper)
                    } label: {
                        Button{
                            if allSelected{
                                viewModel.generateRandomNumber()
                                viewModel.navigateToOrderSummary = true
                            }else{
                                viewModel.showingAlert = true
                            }
                        }label: {
                            ConfirmBtn(text: "Buy Ticket", width: 200, height: 60, top: 10, leading: 10, bottom: 10, trailing: 10)
                        }
                    }
                }
                .padding(20)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Invalid Data") ,
                          message: Text("Please select all field."),
                          dismissButton: .destructive(Text("OK")))
                }
                
            }
            .background(.black)
            .navigationBarBackButtonHidden(true)
            .onChange(of: viewModel.date, {
                if dateHourBothTrue{
                    Task{
                        let date = "\(viewModel.date.day)-\(viewModel.date.month)-\(viewModel.date.year)"
                        await fireDBHelper.getUnavailableChair(movieTitle: movieDetail!.title, cinema: cinema, date: date, hour: viewModel.hour)
                    }
                }else{
                    print("waiting for both conditions to be true")
                }
            })
            .onChange(of: viewModel.hour, {
                if dateHourBothTrue{
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


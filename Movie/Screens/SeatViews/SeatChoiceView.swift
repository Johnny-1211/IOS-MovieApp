
import SwiftUI

struct SeatChoiceView: View {
    @State private var selectedSeats: [Seat] = []
    @State private var showBasket: Bool = false
    @State private var date: TicketDate = TicketDate.default
    @State private var hour: String = ""
    @State private var showingAlert = false
    @State private var navigateToOrderSummary = false
    @StateObject var viewModel = SeatViewModel()
    var movieDetail: MovieDetail?
    var cinema:String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Theatre(selectedSeats: $selectedSeats)
                DateTimeView(date: self.$date, hour: self.$hour)
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
                    
                    NavigationLink(isActive: $navigateToOrderSummary){
                        OrderSummaryView(ticketPrice: viewModel.price,
                                         randomNum: viewModel.randomNum,
                                         movieDetail: movieDetail,
                                         date: date,
                                         hour: hour,
                                         seatCount: selectedSeats.count,
                                         cinema: cinema)
                    } label: {
                        Text("Buy Ticket")
                            .frame(width: 200, height: 60)
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding()
                        //                            .onTapGesture {
                        //                                showingAlert = true
                        //                                viewModel.generateRandomNumber()
                        //                            }
                    }
                    .onTapGesture {
                        showingAlert = true
                        viewModel.generateRandomNumber()
                    }
                    //                                        .alert(isPresented: $showingAlert){
                    //                                            Alert(title: Text("Purchase success"),
                    //                                                  message: Text("Your puchase a ticket of movie - \( String(describing: movieDetail?.title)) at \(hour) on \(date.day)-\(date.month)-\(date.year)"),
                    //                                                  dismissButton: .default(Text("OK")) {
                    //                                                navigateToOrderSummary = true
                    //                                            })
                    //                                        }
                    
                    
                    
                }
                .padding(20)
            }
            .background(.black)
        }
    }
}

#Preview {
    SeatChoiceView()
}

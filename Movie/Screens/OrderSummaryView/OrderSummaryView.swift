import SwiftUI
import UIKit

struct OrderSummaryView: View {
    @State private var showingAlert = false
    @State private var generateTicket = false
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    
    var ticketPrice: Int = 0
    var randomNum : String = ""
    var timerStartd  = false
    var movieDetail : MovieDetail?
    var date: TicketDate?
    var hour: String = ""
    var selectedSeats: [Seat] = []
    var cinema:String = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    AsyncImage(url: URL(string: imageBaseUrl + (movieDetail!.poster_path))) { image in
                        image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150 ,height: 150)
                            .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text(movieDetail!.title)
                            .foregroundStyle(.orange)
                        
                        Text(cinema)
                            .foregroundStyle(.white)
                        Text("\(date!.day)-\(date!.month)-\(date!.year)")
                            .foregroundStyle(.gray)
                    }
                    //                    .padding(.horizontal,20)
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                .background(Color("SectionColor"))
                
                VStack(alignment:.leading, spacing: 20){
                    HStack{
                        Text("ORDER NUMBER : ")
                            .foregroundStyle(.white)
                        Text(randomNum)
                            .font(.body.bold())
                            .foregroundStyle(.gray)
                    }
                    
                    HStack{
                        Text("\(selectedSeats.count) Ticket")
                            .foregroundStyle(.white)
                            .font(.body.bold())
                        Spacer()
                        ForEach(selectedSeats) {seat in
                            Text("\(seat.row)\(seat.number)")
                                .font(.body.bold())
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Number of Seat")
                            .font(.body.bold())
                        Spacer()
                        Text("$\(ticketPrice) ")
                        Text("x \(selectedSeats.count)")
                    }
                    .foregroundStyle(.white)
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Service Fee")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                        Spacer()
                        Text("$1.3")
                            .foregroundStyle(.white)
                    }
                    
                    Text("Payment Method")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    HStack{
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 40))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                            .foregroundStyle(.white)
                        Spacer()
                        VStack(alignment:.leading){
                            Text("MasterCard")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            
                            Text("**** **** 1234 5678")
                                .font(.title3)
                                .foregroundStyle(.gray)
                        }
                        .padding(15)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("SectionColor"))
                    .cornerRadius(12)
                    
                    //                    HStack{
                    //                        Text("Complete your payment in")
                    //                            .font(.body.bold())
                    //                            .foregroundStyle(.white)
                    //                        Spacer()
                    //                        PaymentTimer()
                    //                    }
                    //                    .frame(maxWidth: .infinity)
                    //                    .padding()
                    //                    .overlay{
                    //                        Color.orange
                    //                            .opacity(0.3)
                    //                            .cornerRadius(12)
                    //                    }
                    
                    NavigationLink(
                        destination:
                            TicketView(movieDetail: movieDetail,
                                       date: date,
                                       hour: hour,
                                       selectedSeats: selectedSeats,
                                       cinema: cinema,
                                       orderID: randomNum,
                                       ticketPrice: ticketPrice),
                        isActive: $generateTicket
                    ){
                        Button{
                            showingAlert = true
                        }label: {
                            Text("Purchase | $\(ticketPrice * selectedSeats.count)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                                .background(.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                        }
                        .alert(isPresented: $showingAlert){
                            Alert(title: Text("Purchase success"),
                                  message: Text("Your puchase a ticket of movie - \( String(describing: movieDetail?.title)) at \(hour) on \(date!.day)-\(date!.month)-\(date!.year)"),
                                  dismissButton: .default(Text("OK")) {
                                generateTicket = true
                            })
                        }
                    }
                }
                .padding(20)
                Spacer()
            }
            .background(.black)
        }
    }
}

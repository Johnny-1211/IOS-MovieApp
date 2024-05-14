import SwiftUI
import UIKit

struct OrderSummaryView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var showingAlert = false
    @State private var generateTicket = false
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @Binding var dismissSheet : Bool
    
    @State var movieOrder : MovieOrder?
    var ticketPrice: Int = 0
    var orderNum : String = ""
    var timerStartd  = false
    var movieDetail : MovieDetail?
    var date: TicketDate?
    var hour: String = ""
    var selectedSeats: [Seat] = []
    var cinema:String = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 0.0){
                VStack(alignment: .leading){
                    BackBtn()
                        .padding(.horizontal, 20)
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
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                }
                .background(Color("SectionColor"))
                
                VStack(alignment:.leading, spacing: 20){
                    OrderInfoCell(infoTitle: "ORDER NUMBER : ", infoDetail: orderNum)
                    
                    HStack{
                        Text("\(selectedSeats.count) Ticket")
                            .foregroundStyle(.white)
                            .font(.body.bold())
                        Spacer()
                        ForEach(selectedSeats) {seat in
                            Text("\(seat.seatNum)")
                                .font(.body.bold())
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Divider()
                        .background(.white)
                    
                    OrderInfoCell(infoTitle: "Number of Seat:", infoDetail: "$\(ticketPrice) x \(selectedSeats.count)")
                    
                    Divider()
                        .background(.white)
                    
                    OrderInfoCell(infoTitle: "Service Fee:", infoDetail: "$1.3")
                    
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
                            
                            Text("**** **** 3823 7240")
                                .font(.title3)
                                .foregroundStyle(.gray)
                        }
                        .padding(15)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("SectionColor"))
                    .cornerRadius(12)
                    
                    NavigationLink(isActive: $generateTicket){
                        TicketView(dismissSheet: $dismissSheet, movieOrder: movieOrder)
                    }label: {
                        Button{
                            fireDBHelper.insertMovie(newMovie: movieOrder!)
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
            .navigationBarBackButtonHidden(true)
            .onAppear {
                let date = "\(date!.day)-\(date!.month)-\(date!.year)"
                movieOrder = MovieOrder(title: movieDetail?.title ?? "",
                                        orderNum: orderNum,
                                        date: date,
                                        hour: hour,
                                        selectedSeats: selectedSeats,
                                        cinema: cinema,
                                        ticketPrice: ticketPrice,
                                        image:  movieDetail?.poster_path ?? "")
            }

        }
    }
}


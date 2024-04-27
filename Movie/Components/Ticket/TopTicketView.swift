import SwiftUI

struct TopTicketView: View {
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    var movieDetail : MovieDetail?
    var date: TicketDate?
    var hour: String?
    var selectedSeats: [Seat] = []
    var cinema:String?
    var orderID: String?
    var ticketPrice: Int?
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imageBaseUrl + (movieDetail!.poster_path))) { image in
                image
                    .image?.resizable()
                    .modifier(FullWidthModifier())
                    .frame(height: 180)
                    .scaledToFit()
            }
            
            VStack(alignment: .leading) {
                Text(movieDetail!.title)
                    .font(.system(size: 22, weight: .black))
                    .foregroundStyle(.black)
                Text("Show this ticket at the entrance")
                    .font(.body)
                    .foregroundStyle(.gray)
            }
            .frame(minWidth: 0.0, maxWidth:.infinity, alignment: .leading)
            .padding(.horizontal,30)
            
            Divider()
                .padding(.top,10)
                .padding(.horizontal, 30)
             
            VStack(alignment: .leading){
                HStack{
                    TicketDetailView(detail1: "Cinema", detail2: cinema!)
                    Spacer()
                }
                HStack{
                    VStack(alignment:. leading){
                        TicketDetailView(detail1: "Date", detail2: "\(date!.day) \(date!.month) \(date!.year)")
                        TicketDetailView(detail1: "Section", detail2: "5")
                        TicketDetailView(detail1: "Cost", detail2: String(ticketPrice!))
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        TicketDetailView(detail1: "Time", detail2: hour!)
                        VStack(alignment: .leading, spacing: 10){
                            Text("Seat")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.gray)
                            HStack{
                                ForEach(selectedSeats) {seat in
                                    Text("\(seat.row)\(String(seat.number))")
                                        .font(.system(size: 18, weight: .black))
                                }
                            }
                            .padding(.vertical,5)
                            .foregroundStyle(.black)
                        }
                        TicketDetailView(detail1: "Order ID", detail2: orderID!)
                        Spacer()
                    }
                    Spacer()

                }
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        

    }
}

#Preview {
    TopTicketView()
}

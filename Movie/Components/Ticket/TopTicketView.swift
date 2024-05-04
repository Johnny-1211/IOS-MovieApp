import SwiftUI

struct TopTicketView: View {
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    var movieOrder: MovieOrder?
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imageBaseUrl + (movieOrder!.image))) { image in
                image
                    .resizable()
                    .modifier(FullWidthModifier())
                    .frame(height: 180)
                //                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading) {
                Text(movieOrder!.title)
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
                    TicketDetailView(detail1: "Cinema", detail2: movieOrder!.cinema)
                    Spacer()
                }
                HStack{
                    VStack(alignment:. leading){
                        TicketDetailView(detail1: "Date", detail2: "\(movieOrder!.date)")
                        TicketDetailView(detail1: "Section", detail2: "5")
                        TicketDetailView(detail1: "Cost", detail2: "\(movieOrder!.ticketPrice)")
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        TicketDetailView(detail1: "Time", detail2: movieOrder!.hour)
                        VStack(alignment: .leading, spacing: 10){
                            Text("Seat")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.gray)
                            HStack{
                                ForEach(movieOrder!.selectedSeats) {seat in
                                    Text("\(seat.seatNum)")
                                        .font(.system(size: 18, weight: .black))
                                }
                            }
                            .padding(.vertical,5)
                            .foregroundStyle(.black)
                        }
                        TicketDetailView(detail1: "Order ID", detail2: movieOrder!.orderNum)
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

import SwiftUI

struct TicketView: View {

    var movieDetail : MovieDetail?
    var date: TicketDate?
    var hour: String = ""
    var selectedSeats: [Seat] = []
    var cinema:String = ""
    var orderID: String = ""
    var ticketPrice: Int = 0
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                TopTicketView(movieDetail: movieDetail,
                              date: date, 
                              hour: hour,
                              selectedSeats: selectedSeats,
                              cinema: cinema,
                              orderID: orderID, 
                              ticketPrice: ticketPrice)
                    .background(Color.white)
                    .clipShape(TicketShape())
                    .modifier(CardStyleModifier())
                
                DashSeparator()
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 1,dash: [4,8], dashPhase: 4))
                    .frame(height: 0.4)
                    .padding(.horizontal)
                
                BottomTicketView()
                    .background(Color.white)
                    .clipShape(TicketShape().rotation(Angle(degrees: 180)))
                    .modifier(CardStyleModifier())
            }
            .padding(.horizontal)
            .padding(.top, 20)

        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

#Preview {
    TicketView()
}

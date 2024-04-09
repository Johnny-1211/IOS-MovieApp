
import SwiftUI

struct SeatChoiceView: View {
    //    @State private var movie: Movie
    
    @State private var selectedSeats: [Seat] = []
    @State private var showBasket: Bool = false
    @State private var date: TicketDate = TicketDate.default
    @State private var hour: String = ""
    @State private var showPopup = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Theatre(selectedSeats: $selectedSeats)
                DateTimeView(date: self.$date, hour: self.$hour)
                HStack{
                    VStack(alignment:.leading){
                        Text("Price")
                            .foregroundStyle(.gray)
                        Text("$30.3")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("Buy Ticket")
                            .font(.title3.bold())
                            .frame(width: 200, height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .padding()
                    
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

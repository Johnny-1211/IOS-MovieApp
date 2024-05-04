import SwiftUI

struct TicketView: View {
//    @Binding var rootScreen : RootView
    var movieOrder: MovieOrder?
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                TopTicketView(movieOrder: movieOrder)
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
            .padding(.top, 25)
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

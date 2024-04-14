import SwiftUI

struct TicketView: View {
    var studioName = "studio"
    var movieTitle = "ONLY GOD FORGIVES"
    var imageName = "terminator.jpg"

    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                TopTicketView(studioName: studioName, movieTitle: movieTitle, imageName: imageName)
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
            .padding()
        }
        
        
    }
}

#Preview {
    TicketView()
}

import SwiftUI

struct TopTicketView: View {
    var studioName = "studio"
    var movieTitle = "ONLY GOD FORGIVES"
    var imageName = "terminator.jpg"
    
    var body: some View {
        VStack{
            Image("thor")
                .resizable()
                .modifier(FullWidthModifier())
                .frame(height: 200)
                .scaledToFit()
            
            VStack(alignment: .leading) {
                Text("movieTitle")
                    .font(.system(size: 30, weight: .black))
            }.frame(minWidth: 0.0, maxWidth:.infinity, alignment: .leading)
                .padding(.top, 30)
                .padding(.horizontal,30)

            HStack{
                TicketDetailView(detail1: "SCREEN", detail2: "18", detail3: "PRICE", detail4: "$5.68")
                TicketDetailView(detail1: "ROW", detail2: "H", detail3: "DATE", detail4: "23/05/13")
                TicketDetailView(detail1: "SEAT", detail2: "34", detail3: "TIME", detail4: "18:15")
            }.padding(.vertical)
        }
    }
}

#Preview {
    TopTicketView()
}

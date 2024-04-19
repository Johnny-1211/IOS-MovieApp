import SwiftUI

struct TicketDetailView: View {
    
    var detail1 :String
    var detail2 :String
    var detail3 :String
    var detail4 :String

    
    var body: some View {
        VStack(spacing: 10){
            VStack {
                Text(detail1)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.gray)
                Text(detail2)
                    .font(.system(size: 30, weight: .black))
            }
            VStack {
                Text(detail3)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.gray)
                Text(detail4).font(.system(size: 15, weight: .bold))
            }
        }.modifier(FullWidthModifier())
        
    }
}


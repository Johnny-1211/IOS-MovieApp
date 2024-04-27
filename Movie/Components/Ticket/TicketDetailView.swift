import SwiftUI

struct TicketDetailView: View {
    
    var detail1 :String
    var detail2 :String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(detail1)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
            Text(detail2)
                .font(.system(size: 18, weight: .black))
                .foregroundStyle(.black)
        }
        .padding(.vertical,5)
    }
}


import SwiftUI

struct OrderInfoCell: View {
    let infoTitle:String
    let infoDetail:String
    
    var body: some View {
        HStack{
            Text(infoTitle)
                .font(.body.bold())
                .foregroundStyle(.white)
            Spacer()
            Text(infoDetail)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    OrderInfoCell(infoTitle: "Number of Seat",
                  infoDetail: "123")
}

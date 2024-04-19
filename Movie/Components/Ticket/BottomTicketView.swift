import SwiftUI

struct BottomTicketView: View {
    var body: some View {
        Image("traditional-barcode")
            .resizable()
            .scaledToFit()
//            .padding(30)
            .modifier(FullWidthModifier())
    }
}

#Preview {
    BottomTicketView()
}

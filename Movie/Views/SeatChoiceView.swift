
import SwiftUI

struct SeatChoiceView: View {
    

        
    @State private var selectedSeats: [Seat] = []
    @State private var showBasket: Bool = false
    @State private var hour: String = ""
    @State private var showPopup = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SeatChoiceView()
}

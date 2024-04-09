import SwiftUI

struct DateTimeView: View {
    @State private var selectedDate: TicketDate = TicketDate.default
        @State private var selectedHourndex: Int = -1
        private let dates = Date.getFollowingThirtyDays()
        
        @Binding var date: TicketDate
        @Binding var hour: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
//
//#Preview {
//    DateTimeView()
//}

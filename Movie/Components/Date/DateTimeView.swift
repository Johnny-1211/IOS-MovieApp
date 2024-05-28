import SwiftUI

struct DateTimeView: View {
    @State private var selectedDate: TicketDate = TicketDate.default
    @State private var selectedHourndex: Int = -1
    private let dates = Date.getFollowingThirtyDays()
    
    var movieTitle: String = ""
    var cinema: String = ""
    @Binding var date: TicketDate
    @Binding var hour: String
    @Binding var dateSelected: Bool
    @Binding var hourSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            createDateView()
            createTimeView()
        }
    }
    fileprivate func createDateView() -> some View{
        VStack(alignment: .leading) {
            Text("Date")
                .font(.headline).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(dates, id: \.day){ date in
                        DateView(dateSelected: $dateSelected,movieTitle: movieTitle, cinema: cinema, date: date, isSelected: self.selectedDate.day == date.day) { selectedDate in
                            self.selectedDate = selectedDate
                            self.date = selectedDate
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
    
    fileprivate func createTimeView() -> some View {
        VStack(alignment: .leading) {
            Text("Time").font(.headline).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(0..<24, id: \.self){ i in
                        TimeView(hourSelected: $hourSelected ,index: i, isSelected: self.selectedHourndex == i, onSelect: { selectedIndex in
                            self.selectedHourndex = selectedIndex
                            self.hour = "\(selectedIndex):00"
                        })
                    }
                }.padding(.horizontal)
            }
        }
    }
}
//
//#Preview {
//    DateTimeView()
//}

import SwiftUI

struct DateView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var dateSelected: Bool
    
    var movieTitle: String = ""
    var cinema: String = ""
    var date : TicketDate
    var isSelected: Bool
    var onSelect: ((TicketDate)->()) = {_ in }
    var body: some View {
        VStack{
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 50.0,
                bottomLeading: 50.0,
                bottomTrailing: 50.0,
                topTrailing: 50.0),
                                   style: .continuous)
            .frame(width: 60, height: 100)
            .foregroundStyle(isSelected ? .orange : .gray)
            .overlay{
                Circle()
                    .frame(width: 45, height: 45)
                    .padding(.top, 42)
                    .foregroundStyle(isSelected ? .white : .gray)
            }
            .overlay{
                Text("\(date.month)")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                Text("\(date.day)")
                    .font(.title3.bold())
                    .foregroundStyle(isSelected ? .black : .white)
                    .padding(.top, 45)
            }
            
        }
        .onTapGesture {
            self.onSelect(date)
            dateSelected = true
        }
    }
}



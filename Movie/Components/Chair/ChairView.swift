import SwiftUI

struct ChairView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @StateObject var viewModel = SeatViewModel()
    
    var width: CGFloat = 50
    var accentColor: Color
    var reservedColor: Color
    var seat = Seat.default
    @State private var isSelected = false
    @State private var notAvailable = false
    @State private var isSelectable = true
    var onSelect: ((Seat)->()) = {_ in }
    var onDeselect: ((Seat)->()) = {_ in }
    
    var body: some View {
        VStack(spacing: 2) {
            Rectangle()
                .frame(width: self.width, height: self.width * 2/3)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : reservedColor)
                .cornerRadius(width / 5)
                .overlay{
                    Text("\(seat.seatNum)")
                }
            
            Rectangle()
                .frame(width: width - 10, height: width / 5)
                .foregroundColor(isSelectable ? isSelected ? accentColor :  Color.gray.opacity(0.5) : reservedColor)
                .cornerRadius(width / 5)
        }
        .onTapGesture {
            if self.isSelectable{
                self.isSelected.toggle()
                if self.isSelected{
                    self.onSelect(self.seat)
                } else {
                    self.onDeselect(self.seat)
                }
            }
        }
        .onAppear{
            updateSelectableState(with: fireDBHelper.bookedChair)
        }
        .onReceive(fireDBHelper.$bookedChair) { bookChairs in
            updateSelectableState(with: bookChairs)
        }
    }
    
    private func updateSelectableState(with bookedChairs: [BookedChair]) {
        if !bookedChairs.isEmpty {
            for bookedChair in bookedChairs {
                for selectedSeat in bookedChair.selectedSeats {
                    if selectedSeat.seatNum == seat.seatNum {
                        isSelectable = false
                        return
                    }
                }
            }
        }
        isSelectable = true
        isSelected = false
    }
}


import SwiftUI

struct Theatre: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Binding var selectedSeats:[Seat]

    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.3), .clear]) , startPoint: .init(x: 0.5, y: 0.0), endPoint: .init(x: 0.5, y: 0.5)) )
                .frame(height: 420)
                .clipShape(ScreenShape(isClip: true))
                .cornerRadius(20)
            
            ScreenShape()
                .stroke(style:  StrokeStyle(lineWidth: 5,  lineCap: .square ))
                .frame(height: 420)
                .foregroundColor(Color.orange)
            
            VStack {
                createFrontRows()
                createBackRows()
                createSeatsLegend()
            }
        }
        
    }
    
    fileprivate func createFrontRows() -> some View {
        
        let rows: Int = 2
        let rowMark = ["A", "B"]
        let numbersPerRow: Int = 7
        
        return
        
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack{
                    ForEach(0..<numbersPerRow, id: \.self){ number in
                        var isSelectable = true
                        var isSelected = false
                        
                        ChairView(width: 30, accentColor: .orange, reservedColor: .purple,seat: Seat(id: UUID(), seatNum: "\(rowMark[row])\(number + 1)"), onSelect: { seat in
                            self.selectedSeats.append(seat)
                        }, onDeselect: { seat in
                            self.selectedSeats.removeAll(where: {$0.id == seat.id})
                        })
                    }
                }
            }
        }
    }
    
    fileprivate func createBackRows() -> some View {
        let rows: Int = 5
        let rowMark = ["C", "D","E","F","G"]
        let numbersPerRow: Int = 9
        
        return
        
        VStack{
            ForEach(0..<rows, id: \.self) { row in
                HStack{
                    ForEach(0..<numbersPerRow, id: \.self){ number in
                        ChairView(width: 30, accentColor: .orange, reservedColor: .purple,seat: Seat(id: UUID(), seatNum: "\(rowMark[row])\(number + 1)") , onSelect: { seat in
                            self.selectedSeats.append(seat)
                        }, onDeselect: { seat in
                            self.selectedSeats.removeAll(where: {$0.id == seat.id})
                        })
                    }
                }
            }
        }
    }
    
    fileprivate func createSeatsLegend() -> some View{
        HStack{
            ChairLegend(text: "Selected", color: Color.orange)
            ChairLegend(text: "Reserved", color: Color.purple)
            ChairLegend(text: "Available", color: Color.gray)
        }.padding(.horizontal, 20).padding(.top)
    }
}

#Preview {
    @State var selectedSeats : [Seat] = []
    @State var cinema = ""
    return Theatre(selectedSeats: $selectedSeats)
}


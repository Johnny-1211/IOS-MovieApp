import SwiftUI

struct Theatre: View {
    
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
                            Text(rowMark[row])
                                .foregroundStyle(.white)
                                .padding(.leading, 5)
                            ForEach(0..<numbersPerRow, id: \.self){ number in
                                ChairView(width: 30, accentColor: .orange, seat: Seat(id: UUID(), row: rowMark[row], number: number + 1) , onSelect: { seat in
                                    self.selectedSeats.append(seat)
                                }, onDeselect: { seat in
                                    self.selectedSeats.removeAll(where: {$0.id == seat.id})
                                })
                            }
                            
                        }
                        .padding(.trailing,25)
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
                            Text(rowMark[row])
                                .foregroundStyle(.white)
                                .padding(.leading, 5)
                            ForEach(0..<numbersPerRow, id: \.self){ number in
                                ChairView(width: 30, accentColor: .orange, seat: Seat(id: UUID(), row: rowMark[row], number: number + 1) , onSelect: { seat in
                                    self.selectedSeats.append(seat)
                                }, onDeselect: { seat in
                                    self.selectedSeats.removeAll(where: {$0.number == seat.number})
                                })
                            }
                        }
                        .padding(.trailing, 23)
                    }
            }
        }
    fileprivate func createSeatsLegend() -> some View{
        HStack{
            ChairLegend(text: "Selected", color: .orange)
            ChairLegend(text: "Reserved", color: .purple)
            ChairLegend(text: "Available", color: .gray)
        }.padding(.horizontal, 20).padding(.top)
    }
}


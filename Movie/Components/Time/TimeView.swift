import SwiftUI

struct TimeView: View {
    @Binding var hourSelected: Bool

    var index: Int
    var isSelected: Bool
    var onSelect: ((Int)->()) = {_ in }
    var body: some View {
        Text("\(index):00")
            .foregroundColor(isSelected ? .orange : .gray)
            .font(.title3.bold())
            .padding()
            .background( isSelected ? Color.orange.opacity(0.3) : Color.gray.opacity(0.3))
            .cornerRadius(10)
            .onTapGesture {
                self.onSelect(self.index)
                hourSelected = true
            }
            .overlay{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(self.isSelected ? Color.orange : Color("SectionColor"), lineWidth: 2)
            }
    }
}

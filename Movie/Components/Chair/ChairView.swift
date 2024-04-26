//
//  ChairView.swift
//  Movie
//
//  Created by Johnny Tam on 8/4/2024.
//

import SwiftUI

struct ChairView: View {
    
    var width: CGFloat = 50
    var accentColor: Color = .orange
    var seat = Seat.default
    @State private var isSelected = false
    var isSelectable = true
    var onSelect: ((Seat)->()) = {_ in }
    var onDeselect: ((Seat)->()) = {_ in }
    
    var body: some View {
        VStack(spacing: 2) {
            Rectangle()
                .frame(width: self.width, height: self.width * 2/3)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : accentColor)
                .cornerRadius(width / 5)
                .overlay{
                    Text("\(seat.number)")
                }
            
            Rectangle()
                .frame(width: width - 10, height: width / 5)
                .foregroundColor(isSelectable ? isSelected ? accentColor :  Color.gray.opacity(0.5) : accentColor)
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
    }
}

#Preview {
    ChairView()
}

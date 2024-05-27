//
//  ChairLegend.swift
//  Movie
//
//  Created by Johnny Tam on 8/4/2024.
//

import SwiftUI

struct ChairLegend: View {
    var text = "Selected"
    var color: Color
    
    var body: some View {
        HStack{
            ChairView(width: 20, accentColor: color, reservedColor: Color.clear)
            Text(text).font(.subheadline).foregroundColor(color)
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    ChairLegend(color: Color.gray)
}

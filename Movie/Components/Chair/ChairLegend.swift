//
//  ChairLegend.swift
//  Movie
//
//  Created by Johnny Tam on 8/4/2024.
//

import SwiftUI

struct ChairLegend: View {
    var text = "Selected"
    var color: Color = .gray
    
    var body: some View {
        HStack{
             ChairView(width: 20,accentColor: color, isSelectable: false)
            Text(text).font(.subheadline).foregroundColor(color)
        }.frame(maxWidth: .infinity)
    }
}
struct ChairLegend_Previews: PreviewProvider {
    static var previews: some View {
        ChairLegend()
    }
}

#Preview {
    ChairLegend()
}

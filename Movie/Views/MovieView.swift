//
//  MovieView.swift
//  Movie
//
//  Created by Johnny Tam on 30/3/2024.
//

import SwiftUI

struct MovieView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image("thor")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Hello, World!")
                }
                
            }
        }
        
        
        
    }
}

#Preview {
    MovieView()
}

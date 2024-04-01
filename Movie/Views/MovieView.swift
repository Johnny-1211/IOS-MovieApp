//
//  MovieView.swift
//  Movie
//
//  Created by Johnny Tam on 30/3/2024.
//

import SwiftUI

struct MovieView: View {
    @State private var nowPlayingMovie = ["thor","thor","thor","thor"]
    @State private var tapped = false
    @State private var selectedCinema = 0
    @State private var gradient = [Color.black.opacity(0),Color.black,Color.black,Color.black]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("thor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                
                VStack{
                    LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
                        .frame(height: 750)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                VStack(spacing:0.0){
                    HStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 45)
                            .foregroundStyle(.white)
                            .overlay{
                                Button{
                                    
                                } label: {
                                    Image(systemName: "arrow.left")
                                        .foregroundStyle(.white)
                                }
                            }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 46, leading: 20, bottom: 0, trailing: 20))
                    
                    
                    Rectangle()
                        .fill(Color("SectionColor"))
                        .frame(width: 340,height: 180)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                        .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                        .overlay{
                            VStack(alignment:.leading, spacing: 25){
                                HStack{
                                    Text("Movie Name: Thor")
                                        .font(.title3.bold())
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Button(action: {}, label: {
                                        Image(systemName: "bookmark.circle")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 30))
                                    })
                                }
                                
                                Text("Date: 2022 · Adventure · 2 | 28m ")
                                    .font(.body)
                                    .foregroundStyle(.gray)
                                Text("Director: Peter")
                                    .font(.body)
                                    .foregroundStyle(.gray)
                            }
                            .padding(EdgeInsets(top: 60, leading: 20, bottom: 0, trailing: 20))
                        }
                    
                    HStack{
                        ScrollView(.vertical){
                            VStack(alignment: .leading){
                                Text("Description")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                
                                
                                Text("Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless villain Hela.")
                                    .frame(width: 300, height: 100)
                                    .font(.body)
                                    .foregroundStyle(.gray)
                                
                                Text("Cast")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 20){
                                        ForEach(nowPlayingMovie, id: \.self){ movie in
                                            Section{
                                                HStack{
                                                    Image(movie)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 80)
                                                        .cornerRadius(12)
                                                        .scrollTransition(.animated){ content, phase in
                                                            content
                                                                .scaleEffect(phase != .identity ? 0.8 : 1)
                                                                .opacity(phase != .identity ? 0.3 : 1)
                                                        }
                                                    Spacer()
                                                    Text("Tom Holland")
                                                        .font(.body)
                                                        .foregroundStyle(.white)
                                                }
                                                .padding(EdgeInsets(top: 5 , leading: 10, bottom: 5, trailing: 10))
                                            }
                                            .frame(width: 170, height: 75)
                                            .background(Color("SectionColor"))
                                            .cornerRadius(12)
                                        }
                                    }
                                }
                                
                                Text("Cinema")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                ScrollView(.vertical){
                                    VStack(alignment:.leading){
                                        ForEach(0...4, id: \.self){ index in
                                            VStack(alignment:.leading){
                                                Text("HARTONO MALL CGV")
                                                    .font(.body.bold())
                                                    .foregroundStyle(.white)
                                                
                                                Text("4.53 Km | Jl. Ring Road Utara Jl. Kaliw")
                                                    .font(.body)
                                                    .foregroundStyle(.gray)
                                            }
                                            .frame(height: 60)
                                            .frame(maxWidth: .infinity,
                                                   alignment: .leading)
                                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                            .background(Color("SectionColor"))
                                            .onTapGesture {
                                                tapped = true
                                            }
                                        }
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 20))
                        }
                    }
                    
                    Button{
                        
                    }label: {
                        Text("Book Now")
                            .frame(width: 250,height: 40)
                            .font(.title3.bold())
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MovieView()
}

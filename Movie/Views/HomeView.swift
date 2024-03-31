//
//  HomeView.swift
//  Movie
//
//  Created by Johnny Tam on 30/3/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var nowPlayingMovie = ["thor","thor","thor","thor"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                NavigationStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Welcome Johnny👋")
                                .font(.body)
                                .foregroundStyle(.gray)
                            
                            Text("Let's relax and watch a movie.")
                                .font(.body.bold())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    HStack{
                        Text("Now Playing")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("See All")
                                .foregroundStyle(.yellow)
                        })
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30){
                            ForEach(nowPlayingMovie, id: \.self){ movie in
                                VStack{
                                    Image(movie)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 250)
                                        .cornerRadius(12)
                                    
                                    Text("Thor")
                                        .font(.body.bold())
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    HStack{
                        Text("Coming soon")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("See All")
                                .foregroundStyle(.yellow)
                        })
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    ScrollView{
                        VStack{
                            ForEach(nowPlayingMovie, id: \.self){ movie in
                                Section {
                                    HStack{
                                        Image(movie)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120)
                                            .cornerRadius(12)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                        VStack(alignment:.leading,spacing: 10){
                                            Text("Thor (2022)")
                                                .font(.title3.bold())
                                                .foregroundStyle(.white)
                                            
                                            Text("Action, Adventure, Comedy")
                                                .font(.system(size: 15))
                                                .foregroundStyle(.gray)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                }
                                .background(Color("SectionColor"))
                                .cornerRadius(12)
                            }
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
            
        }
    }
}
#Preview {
    HomeView()
}

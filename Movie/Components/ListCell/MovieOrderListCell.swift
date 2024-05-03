import SwiftUI

struct MovieOrderListCell: View {
    @State private var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    var movieOrder: MovieOrder
    
    var body: some View {
        Section {
            HStack{
                AsyncImage(url: URL(string: imageBaseUrl + movieOrder.image)){ image in
                    image
                        .image?.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .cornerRadius(12)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
                
                VStack(alignment: .leading,spacing: 10){
                    Text(movieOrder.title)
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    
                    Text("Order Number: \(movieOrder.orderNum)")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                    Text("Date: \(movieOrder.date)")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                    HStack{
                        Text("Seat Number: ")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                        ForEach(movieOrder.selectedSeats) { seat in
                            Text("\(seat.seatNum) ")
                                .font(.system(size: 15))
                                .foregroundStyle(.gray)
                        }
                    }
                    Text("Cinema: \(movieOrder.cinema)")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            .padding()
        }
        .background(Color("SectionColor"))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


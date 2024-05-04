import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @State var orderList : [MovieOrder] = []
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(self.orderList) { currentOrder in
                        NavigationLink(destination: TicketView(movieOrder: currentOrder), label: {
                            MovieOrderListCell(movieOrder: currentOrder)
                        })
                    }
                }
            }
            
            if fireDBHelper.movieOrder.isEmpty {
                EmptyState(imageName: "movieOrder",
                           message: "You have no items in your order.\nPlease purchase an ticket!")
            }
        }
        .onAppear{
            orderList = fireDBHelper.movieOrder
        }
    }
}

#Preview {
    OrderListView()
}

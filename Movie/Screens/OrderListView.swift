import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var router: Router
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @State var orderList : [MovieOrder] = []
    @State var isActive : Bool = false
    @State private var isShowingTicket = false

    
    var body: some View {
        NavigationStack(path: $router.navPath){
            ScrollView{
                VStack{
                    ForEach(self.orderList) { currentOrder in
                        Button{
                            isShowingTicket = true
                        }label:{
                            MovieOrderListCell(movieOrder: currentOrder)
                        }
                        .fullScreenCover(isPresented: $isShowingTicket) {
                            TicketView(dismissSheet: $isShowingTicket, movieOrder: currentOrder)
                        }
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


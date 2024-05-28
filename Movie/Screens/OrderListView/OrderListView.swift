import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    @State var isActive : Bool = false
    @State private var isShowingTicket = false
    @State private var selectedMovieID : IdentifiableInt?
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    VStack(spacing: 10){
                        Text("OrderList")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                    }
                    .padding(.top,25)
                    .padding(.horizontal, 20)
                    
                    ScrollView{
                        VStack{
                            ForEach(self.fireDBHelper.movieOrder) { currentOrder in
                                Button{
                                    isShowingTicket = true
                                }label:{
                                    MovieOrderListCell(movieOrder: currentOrder)
                                }
                                .fullScreenCover(isPresented: $isShowingTicket) {
                                    TicketView(dismissSheet: $isShowingTicket, selectedMovieID: $selectedMovieID, movieOrder: currentOrder)
                                }
                            }
                        }
                    }
                    
                    if fireDBHelper.movieOrder.isEmpty {
                        EmptyState(imageName: "list.clipboard",
                                   message: "You have no items in your order.\nPlease purchase an ticket!")
                    }
                }
            }
        }
        .refreshable {
            fireDBHelper.getAllMovies()
        }
    }
}


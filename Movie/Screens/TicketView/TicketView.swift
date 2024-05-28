import SwiftUI

struct TicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var dismissSheet : Bool
    @Binding var selectedMovieID: IdentifiableInt?

    var movieOrder: MovieOrder?
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            NavigationStack{
                VStack(alignment: .leading, spacing: 0.0) {
                    Circle()
                        .fill(.gray)
                        .frame(width: 45)
                        .foregroundStyle(.white)
                        .overlay{
                            Button{
                                dismissSheet.toggle()
                                selectedMovieID = nil
                            } label: {
                                Image(systemName: "multiply")
                                    .foregroundStyle(.white)
                            }
                        }
                        .offset(y: -20)
                    
                    
                    TopTicketView(movieOrder: movieOrder)
                        .background(Color.white)
                        .clipShape(TicketShape())
                        .modifier(CardStyleModifier())
                    
                    DashSeparator()
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1,dash: [4,8], dashPhase: 4))
                        .frame(height: 0.4)
                        .padding(.horizontal)
                    
                    BottomTicketView()
                        .background(Color.white)
                        .clipShape(TicketShape().rotation(Angle(degrees: 180)))
                        .modifier(CardStyleModifier())
                }
                .padding(.horizontal)
                .padding(.top, 25)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: EmptyView())

        }
        
        
    }
}

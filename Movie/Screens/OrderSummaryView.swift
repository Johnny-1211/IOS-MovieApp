import SwiftUI
import UIKit

struct OrderSummaryView: View {
    
    var timerStartd  = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Image("thor")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120 ,height: 120)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading){
                        Text("Movie title")
                            .foregroundStyle(.orange)
                        Text("Movie type")
                            .foregroundStyle(.gray)
                        Text("cinema")
                            .foregroundStyle(.white)
                        Text("booking date")
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal,20)
                    Spacer()
                }
                .padding(20)
                .background(Color("SectionColor"))
                
                VStack(alignment:.leading, spacing: 30){
                    HStack{
                        Text("ORDER NUMBER : ")
                            .foregroundStyle(.white)
                        Text("12312312312")
                            .font(.body.bold())
                            .foregroundStyle(.gray)
                    }
                    
                    HStack{
                        Text("(ticket number) Ticket")
                            .foregroundStyle(.white)
                            .font(.body.bold())
                        Spacer()
                        Text("seat number")
                    }
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Number of Seat")
                            .font(.body.bold())
                        Spacer()
                        Text("$30.3")
                        Text("x 3")
                    }
                    .foregroundStyle(.white)
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Service Fee")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                        Spacer()
                        Text("$1.3")
                            .foregroundStyle(.white)
                    }
                    
                    Text("Payment Method")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    HStack{
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 40))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                            .foregroundStyle(.white)
                        Spacer()
                        VStack(alignment:.leading){
                            Text("MasterCard")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            
                            Text("**** **** 1234 5678")
                                .font(.title3)
                                .foregroundStyle(.gray)
                        }
                        .padding(15)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("SectionColor"))
                    .cornerRadius(12)
                    
                    HStack{
                        Text("Complete your payment in")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                        Spacer()
                        PaymentTimer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay{
                        Color.orange
                            .opacity(0.3)
                            .cornerRadius(12)
                    }
                    
                    Button{
                        
                    }label: {
                        Text("Book Now | $30.3 x 3")
                            .font(.body.bold())
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
                .padding(20)
                Spacer()
            }
            .background(.black)
        }
    }
}

#Preview {
    OrderSummaryView()
}

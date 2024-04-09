import SwiftUI

struct OrderSummeryView: View {
    
    var timerStartd  = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Image("thor")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90 ,height: 100)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading){
                        Text("Movie title")
                        Text("Movie type")
                        Text("cinema")
                        Text("bokking date")
                    }
                    Spacer()
                }
                .padding(20)
                .background(.gray)
                
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
                        Spacer()
                        Text("seat number")
                    }
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Number of Seat")
                        Spacer()
                        Text("$30.3")
                        Text("x 3")
                    }
                    .foregroundStyle(.white)
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        Text("Service Fee")
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
                        VStack(alignment:.leading){
                            Text("MasterCard")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            
                            Text("**** **** 1234 5678")
                                .font(.title3)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical, 20)
                        .frame(width: 265)
                    }
                    .background(Color("SectionColor"))
                    .cornerRadius(12)
                    
                    HStack{
                        Text("Complete your payment in")
                            .font(.body.bold())
                            .foregroundStyle(.white)
                        Spacer()
                        PaymentTimer()
                    }
                    .frame(width: 320)
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
                            .frame(width: 300, height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .padding()
                }
                .padding(20)
                
                
                
                
                
                Spacer()
            }
            .background(.black)
        }
    }
}

#Preview {
    OrderSummeryView()
}

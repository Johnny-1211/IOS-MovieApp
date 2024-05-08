import SwiftUI

struct ConfirmBtn: View {
    
    var text:String
    var width: CGFloat
    var height: CGFloat
    var top : CGFloat = 0
    var leading : CGFloat = 0
    var bottom : CGFloat = 0
    var trailing : CGFloat = 0
    
    var body: some View {
        Text(text)
            .frame(width: width, height: height)
            .font(.title3.bold())
            .foregroundStyle(.white)
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))    }
}

#Preview {
    ConfirmBtn(text: "Book Now", width: 250, height: 50, top: 10, leading: 0, bottom: 20, trailing: 0)
}

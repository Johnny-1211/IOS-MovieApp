import SwiftUI

struct EmptyState: View {
    
    let imageName: String
    let message: String
    
    var body: some View {
                
        VStack {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            Text(message)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
            Spacer()
        }
        .offset(y: -50)
    }
}


#Preview {
    EmptyState(imageName: "movieclapper", message: "This is our test message.\nI'm making it a little long for testing.")
}

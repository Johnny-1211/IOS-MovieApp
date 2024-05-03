import SwiftUI

struct BackBtn: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Circle()
            .fill(.gray)
            .frame(width: 45)
            .foregroundStyle(.white)
            .overlay{
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.white)
                }
            }
    }
}


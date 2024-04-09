import SwiftUI

struct PaymentTimer: View {
    @State private var timeRemaining = 2 * 60 * 60
    
    var body: some View {
        Text("\(formattedTime(timeRemaining))")
            .font(.title3.bold())
            .foregroundStyle(.orange)
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        timer.invalidate()
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
    }
    
    func formattedTime(_ time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = (time % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    PaymentTimer()
}

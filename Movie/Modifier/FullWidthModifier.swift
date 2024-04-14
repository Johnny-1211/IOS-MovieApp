import SwiftUI

struct FullWidthModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 0.0, maxWidth: .infinity)
    }
}


import SwiftUI

struct CustomScrollTargetBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 70 {
            if target.rect.minY < 35 {
                target.rect.origin = .zero
            } else{
                target.rect.origin = .init(x: 0, y: 70)
            }
        }
    }
}

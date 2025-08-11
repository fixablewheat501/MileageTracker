
import SwiftUI

struct LiquidGlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 15, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color.white.opacity(0.1), radius: 10, x: 0, y: 10)
    }
}

extension View {
    func liquidGlassStyle() -> some View {
        self.modifier(LiquidGlassModifier())
    }
}

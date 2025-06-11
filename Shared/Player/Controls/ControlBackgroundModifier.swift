import Foundation
import SwiftUI

struct ControlBackgroundModifier: ViewModifier {
    public var cornerRadius: CGFloat = 8
    var enabled = true
    var edgesIgnoringSafeArea = Edge.Set()

    func body(content: Content) -> some View {
        if enabled {
            if #available(tvOS 26.0, iOS 26.0, macOS 26.0, *) {
                content
                    .glassEffect(in: .rect(cornerRadius: cornerRadius))
            }
            else if #available(iOS 15, macOS 12, *) {
                content
                    .background(.thinMaterial)
            }
            else {
                content
                #if os(macOS)
                .background(VisualEffectBlur(material: .hudWindow))
                #elseif os(iOS)
                .background(VisualEffectBlur(blurStyle: .systemThinMaterial).edgesIgnoringSafeArea(edgesIgnoringSafeArea))
                #else
                .background(.thinMaterial)
                #endif
            }
        }
    }
}

struct ControlBackgroundModifier_Previews: PreviewProvider {
    static var previews: some View {
        Buffering_Previews.previews;
    }
}

import Defaults
import Foundation
import SwiftUI

struct Buffering: View {
    var reason = "Buffering stream...".localized()
    var state: String?

    @ObservedObject private var player = PlayerModel.shared

    @Default(.playerControlsLayout) private var regularPlayerControlsLayout
    @Default(.fullScreenPlayerControlsLayout) private var fullScreenPlayerControlsLayout

    var playerControlsLayout: PlayerControlsLayout {
        player.playingFullScreen ? fullScreenPlayerControlsLayout : regularPlayerControlsLayout
    }

    var body: some View {
        VStack(spacing: 32) {
            ProgressView()
            #if os(macOS)
                .scaleEffect(0.4)
            #else
                .scaleEffect(0.7)
            #endif
                .frame(maxHeight: 14)
                .progressViewStyle(.circular)

            VStack(spacing: 8) {
                Text(reason)
                    .font(.system(size: playerControlsLayout.timeFontSize))
                if let state {
                    Text(state)
                        .font(.system(size: playerControlsLayout.bufferingStateFontSize).monospacedDigit())
                }
            }
        }
        #if os(tvOS)
        .padding(32)
        .modifier(ControlBackgroundModifier(cornerRadius: 32))
        #else
        .padding(16)
        .modifier(ControlBackgroundModifier(cornerRadius: 8))
        #endif
        .foregroundColor(.secondary)
    }
}

struct Buffering_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Buffering(reason: "Loading streams…")
            
            Buffering(state: "100% (2.95s)")
            
            Buffering(reason: "Opening 1080p stream…", state: nil)
            
            Spacer()
        }
        .padding(100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .ignoresSafeArea()
    }
}

// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct AboutView: View {
  @Environment(\.dismiss) var dismiss
  @GestureState var isDraggingWindow = false

  var dragWindow: some Gesture {
    WindowDragGesture()
      .updating($isDraggingWindow) { _, state, _ in
        state = true
      }
  }

  var body: some View {
    VStack(spacing: 20) {
      Text("SwiftUI for Mac 2024")
        .font(.title)
      Text("This app accompanies my article on SwiftUI for Mac 2024.")
      Text("Click and drag to move this window.")

      HStack {
        Button("Go to Article") {
          let url = URL(string: "https://troz.net/post/2024/swiftui-mac-2024/")!
          NSWorkspace.shared.open(url)
          dismiss()
        }

        Spacer()

        Button("Close") {
          dismiss()
        }
        // doesn't work with a plain window style
        .keyboardShortcut(.cancelAction)
      }
    }
    .padding()
    .background(
      MeshBackground()
    )
    .border(.gray, width: 3)
    .gesture(dragWindow)
    .opacity(isDraggingWindow ? 0.8 : 1)
    .onChange(of: isDraggingWindow) {
      if isDraggingWindow {
        NSCursor.closedHand.push()
      } else {
        NSCursor.pop()
      }
    }
  }

  var windowBg: Color {
    Color(nsColor: .windowBackgroundColor)
  }
}

#Preview {
  AboutView()
    .frame(width: 500, height: 170)
}

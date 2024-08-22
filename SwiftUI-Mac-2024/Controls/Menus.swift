// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct Menus: Commands {
  @Environment(\.openWindow) private var openWindow

  var body: some Commands {
    SidebarCommands()
    ToolbarCommands()

    CommandGroup(after: .textEditing) {
      Button("Flip Image") {
        NotificationCenter.default.post(name: .flipImage, object: nil)
      }
      .keyboardShortcut("f")
    }

    CommandGroup(replacing: .appInfo) {
      Button("About SwiftUI Mac 2024") {
        openWindow(id: "about")
      }
    }

    CommandGroup(replacing: .help) {
      Button("Read Accompanying Article at troz.net") {
        let articleUrl = URL(string: "https://troz.net/post/2024/swiftui-mac-2024/")!
        NSWorkspace.shared.open(articleUrl)
      }
    }
  }
}

extension Notification.Name {
  static let flipImage = Notification.Name("flipImage")
}

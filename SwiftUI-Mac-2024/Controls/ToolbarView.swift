// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct ToolbarView: CustomizableToolbarContent {
  @Environment(\.openWindow) private var openWindow

  let httpStatus: HttpStatus?

  var body: some CustomizableToolbarContent {
    ToolbarItem(id: "flip_image") {
      Button {
        NotificationCenter.default.post(name: .flipImage, object: nil)
      } label: {
        Label(
          "Flip Image",
          systemImage: "flip.horizontal"
        )
      }
      .disabled(httpStatus == nil)
      .help("Flip the image horizontally.")
    }


    ToolbarItem(id: "show_samples") {
      Button {
        openWindow(id: "ui_samples")
      } label: {
        Label(
          "Show Samples",
          systemImage: "uiwindow.split.2x1"
        )
      }
      .help("Show UI Samples")
    }
  }
}

// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct MenuBarView: View {
  @Binding var httpSections: [HttpSection]

  var body: some View {
    ForEach(httpSections) { section in
      Menu("\(section.headerCode) - \(section.headerText)") {
        ForEach(section.statuses) { status in
          Button("\(status.code) - \(status.title)") {
            NSWorkspace.shared.open(status.docsUrl)
          }
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var httpSections: [HttpSection] = HttpSection.localData
  MenuBarView(httpSections: $httpSections)
}

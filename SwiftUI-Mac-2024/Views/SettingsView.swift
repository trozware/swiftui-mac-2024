// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct SettingsView: View {
  @AppStorage("showCopyright") var showCopyright: Bool = false
  @AppStorage("showMenuBar") var showMenuBar = true

  var body: some View {
    Form {
      Toggle(isOn: $showCopyright) {
        Text("Show Copyright Notice")
      }
      Toggle(isOn: $showMenuBar) {
        Text("Show Menu Bar App")
      }
    }
    .frame(width: 300, height: 130)
    .navigationTitle("Settings")
  }
}

#Preview {
  SettingsView()
}

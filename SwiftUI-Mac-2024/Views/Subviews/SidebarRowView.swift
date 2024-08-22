// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct SidebarRowView: View {
  let code: String
  let title: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(code)
        .font(.largeTitle)
        .foregroundColor(.primary)

      Text(title)
        .font(.title2)
        .truncationMode(.tail)
    }
    .padding(.horizontal)
    .padding(.vertical, 3)
  }
}

#Preview {
  SidebarRowView(code: "418", title: "I'm a teapot")
}

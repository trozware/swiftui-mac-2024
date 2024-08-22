// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct DetailView: View {
  @Environment(\.openWindow) private var openWindow

  let sectionTitle: String?
  let httpStatus: HttpStatus?

  var body: some View {
    VStack {
      if let sectionTitle, let httpStatus {
        StatusView(sectionTitle: sectionTitle, httpStatus: httpStatus)
      } else {
        Spacer()
        Text("Select a status.")
          .font(.largeTitle)
          .navigationTitle("HTTP Status")
      }
      Spacer()
    }
    .toolbar(id: "detail_toolbar") {
      ToolbarView(httpStatus: httpStatus)
    }
  }
}

#Preview {
  DetailView(sectionTitle: nil, httpStatus: nil)
}

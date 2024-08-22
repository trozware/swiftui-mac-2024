// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct SamplesView: View {
  var body: some View {
    TabView {
      Tab("Chart", systemImage: "chart.bar.doc.horizontal") {
        ChartSamplesView()
      }
      Tab("Form", systemImage: "list.bullet.clipboard") {
        FormSamplesView()
      }
    }
    //  .tabViewStyle(.sidebarAdaptable)
    //  .tabViewStyle(.grouped)
    .padding()
    .frame(minWidth: 600, minHeight: 550)
  }
}

#Preview {
  SamplesView()
}

// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct ContentView: View {
  let httpSections: [HttpSection]

  @State private var selectedStatus: HttpStatus?

  var body: some View {
    NavigationSplitView {
      SidebarView(httpSections: httpSections, selectedStatus: $selectedStatus)
    } detail: {
      DetailView(sectionTitle: sectionHeader, httpStatus: selectedStatus)
    }
    .frame(minWidth: 650, minHeight: 300)
  }

  var sectionHeader: String? {
    if let selectedStatus {
      let selectedSection = httpSections.first { section in
        section.statuses.contains(selectedStatus)
      }
      return selectedSection?.headerText
    }
    return nil
  }
}

#Preview {
  ContentView(httpSections: HttpSection.localData)
}

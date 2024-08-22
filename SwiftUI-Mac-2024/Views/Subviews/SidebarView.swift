// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct SidebarView: View {
  let httpSections: [HttpSection]
  @Binding var selectedStatus: HttpStatus?

  var body: some View {
    List(httpSections, selection: $selectedStatus) { section in
      Section(
        header: Text("\(section.headerCode) - \(section.headerText)")
      ) {
        ForEach(section.statuses) { status in
          SidebarRowView(
            code: status.code,
            title: status.title
          )
          .tag(status)
        }
      }
      .font(.headline)
    }
    .frame(minWidth: 250)
  }
}

#Preview {
  @Previewable @State var selectedStatus: HttpStatus?
  SidebarView(httpSections: HttpSection.localData, selectedStatus: $selectedStatus)
    .frame(width: 250)

  //  SidebarView(httpSections: HttpSection.localData, selectedStatus: .constant(nil))
  //    .frame(width: 250)
}

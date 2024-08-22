// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct StatusView: View {
  let sectionTitle: String
  let httpStatus: HttpStatus

  @State private var catImage: NSImage?

  var body: some View {
    VStack {
      Text("HTTP Status Code: \(httpStatus.code)")
        .font(.headline)
        .padding()
      Text(httpStatus.title)
        .font(.title)

      AsyncImage(url: httpStatus.imageUrl) { img in
        CatImageView(catImage: img, statusCode: httpStatus.code)
      } placeholder: {
        Spacer()
        ProgressView()
        Spacer()
      }
      .id(httpStatus)   // this resets the AsyncImage whenever httpStatus changes

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("\(sectionTitle) - \(httpStatus.title)")
  }
}

#Preview {
  StatusView(
    sectionTitle: "4xx",
    httpStatus: HttpStatus(code: "404", title: "Not Found")
  )
}

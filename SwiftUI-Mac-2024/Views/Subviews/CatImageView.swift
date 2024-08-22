// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct CatImageView: View {
  @AppStorage("showCopyright") var showCopyright: Bool = false
  @Environment(\.controlActiveState) private var controlActiveState

  private let flipImageMenuItemSelected = NotificationCenter.default
    .publisher(for: .flipImage)
    .receive(on: RunLoop.main)

  let catImage: Image
  let statusCode: String

  @State private var imageIsFlipped = false

  var body: some View {
    VStack {
      catImage
        .resizable()
        .aspectRatio(contentMode: .fit)
        .rotation3DEffect(
          Angle(degrees: imageIsFlipped ? 180 : 0),
          axis: (x: 0, y: 1, z: 0)
        )
        .animation(.default, value: imageIsFlipped)
        .overlay(
          Text(showCopyright ? "Copyright © https" + "://http.cat" : "")
            .padding(6)
            .font(.caption)
            .foregroundColor(.white)
            .shadow(radius: 5), alignment: .bottomTrailing
        )
    }
    .onReceive(flipImageMenuItemSelected) { _ in
      if controlActiveState == .key || controlActiveState == .active {
        imageIsFlipped.toggle()
      }
    }
  }
}

#Preview {
  let image = Image(systemName: "photo.artframe")
  CatImageView(catImage: image, statusCode: "000")
}

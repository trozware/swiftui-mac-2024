// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import SwiftUI

struct MeshBackground: View {
  let points: [SIMD2<Float>] = [
    SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
    SIMD2(0.0, 0.5), SIMD2(0.5, 0.5), SIMD2(1.0, 0.5),
    SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 1.0)
  ]
  let colors: [Color] = [
    .purple, .white, .white,
    .white, .green, .white,
    .white, .white, .orange
  ]

  var body: some View {
    MeshGradient(
      width: 3,
      height: 3,
      points: points,
      colors: colors
    )
  }
}

#Preview {
  MeshBackground()
}

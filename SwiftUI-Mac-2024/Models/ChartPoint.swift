// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import Foundation

struct ChartPoint: Identifiable {
  let id = UUID()
  let category: String
  let count: Int
}

extension ChartPoint {
  static var chartPoints: [ChartPoint] {
    let httpSections = HttpSection.localData
    let points = httpSections.map { section in
      ChartPoint(
        category: section.headerCode,
        count: section.statuses.count
      )
    }
    return points
  }
}

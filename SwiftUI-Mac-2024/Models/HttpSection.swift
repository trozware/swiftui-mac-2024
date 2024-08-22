// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import Foundation

struct HttpSection: Identifiable, Hashable {
  let id = UUID()
  let headerCode: String
  let headerText: String
  let statuses: [HttpStatus]
}

extension HttpSection: Decodable {
  enum CodingKeys: CodingKey {
    case headerCode
    case headerText
    case statuses
  }
}

extension HttpSection {
  static var localData: [HttpSection] {
    guard let url = Bundle.main.url(forResource: "httpcodes", withExtension: "json") else {
      fatalError("Failed to load httpcodes.json")
    }

    do {
      let data = try Data(contentsOf: url)
      let sections = try JSONDecoder().decode([HttpSection].self, from: data)
      return sections
    } catch {
      return []
    }
  }
}

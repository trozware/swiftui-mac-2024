// This sample app accompanies my article on SwiftUI for Mac 2024.
// https://troz.net/post/2024/swiftui-mac-2024/
//
// Sarah Reichelt, August 2024

import Foundation

struct HttpStatus: Identifiable, Hashable {
  let code: String
  let title: String
  var id: String {
    code
  }

  var imageUrl: URL {
    let address = "https://http.cat/\(code).jpg"
    return URL(string: address)!
  }

  var docsUrl: URL {
    let address = "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/\(code)"
    return URL(string: address)!
  }
}

extension HttpStatus: Decodable {
  enum CodingKeys: CodingKey {
    case code
    case title
  }
}

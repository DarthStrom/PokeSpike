import Foundation

struct Pokemon: Codable, Equatable {
    let url: URL
    let name: String

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.url == rhs.url && lhs.name == rhs.name
    }
}

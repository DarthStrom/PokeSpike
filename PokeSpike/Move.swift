import Foundation

struct Move: Codable, Equatable {
    let url: URL
    let name: String

    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.url == rhs.url && lhs.name == rhs.name
    }
}

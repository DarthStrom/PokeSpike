import Foundation

struct MovesResponse: Codable {
    let count: Int
    let previous: URL?
    let results: [Move]
    let next: URL?
}

import Foundation

struct PokemonsResponse: Codable {
    let count: Int
    let previous: URL?
    let results: [Pokemon]
    let next: URL?
}

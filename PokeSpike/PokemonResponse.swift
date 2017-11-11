import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let previous: URL?
    let results: [Pokemon]
    let next: URL?
}

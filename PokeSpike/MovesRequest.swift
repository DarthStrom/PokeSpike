import Foundation

struct MovesRequest: PokeRequest {
    var url: URL {
        return URL(string: "https://pokeapi.co/api/v2/move/")!
    }
}

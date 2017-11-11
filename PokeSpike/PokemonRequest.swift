import Foundation

struct PokemonRequest: PokeRequest {
    var url: URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    }
}

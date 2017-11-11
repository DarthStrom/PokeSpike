import Foundation

struct PokemonsRequest: PokeRequest {
    var url: URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    }
}

import Foundation

class ListViewLogic {

    weak var viewDelegate: ViewDelegate?

    var requestor = ListRequestor()

    var pokemons: [Pokemon]?
    var moves: [Move]?

    func fetchLists() {
        pokemons = [
            Pokemon(url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!,
                    name: "bulbasaur"),
            Pokemon(url: URL(string: "https://pokeapi.co/api/v2/pokemon/2/")!,
                    name: "ivysaur")]
        moves = [
            Move(url: URL(string: "https://pokeapi.co/api/v2/move/1/")!,
                 name: "pound"),
            Move(url: URL(string: "https://pokeapi.co/api/v2/move/2/")!,
                 name: "karate-chop")]

        requestor.logicDelegate = self
        requestor.request()
    }

    func onSuccess(pokemons: [Pokemon]?, moves: [Move]?) {
        self.pokemons = pokemons
        self.moves = moves

        viewDelegate?.onSuccess()
    }
}

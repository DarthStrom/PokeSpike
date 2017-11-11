import Moxie
@testable import PokeSpike

class MockListViewLogic: ListViewLogic, Mock {
    var moxie = Moxie()

    override func onSuccess(pokemons: [Pokemon]?, moves: [Move]?) {
        record(function: "onSuccess", wasCalledWith: [pokemons, moves])
    }
}

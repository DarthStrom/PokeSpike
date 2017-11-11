import Foundation

class ListViewLogic {

    weak var viewDelegate: ViewDelegate?

    var requestor = ListRequestor()

    var pokemons: [Pokemon]?
    var moves: [Move]?

    func fetchLists() {
        requestor.logicDelegate = self
        requestor.request()
    }

    func onSuccess(pokemons: [Pokemon]?, moves: [Move]?) {
        self.pokemons = pokemons
        self.moves = moves

        viewDelegate?.onSuccess()
    }
}

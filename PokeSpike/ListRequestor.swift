import Alamofire

class ResponseHandler<T> {
    func complete(response: T?) {}
}

class ListRequestor {

    weak var logicDelegate: ListViewLogic?

    var requestWrapper = RequestWrapper()

    var pokemons: [Pokemon]?
    var moves: [Move]?

    func request() {
        requestWrapper.request(PokemonsRequest(), handler: PokemonResponseHandler(requestor: self))
        requestWrapper.request(MovesRequest(), handler: MovesResponseHandler(requestor: self))
    }

    func got(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        finish()
    }

    func got(moves: [Move]) {
        self.moves = moves
        finish()
    }

    func finish() {
        if let pokemons = pokemons, let moves = moves {
            logicDelegate?.onSuccess(pokemons: pokemons, moves: moves)
        }
    }

    class PokemonResponseHandler: ResponseHandler<PokemonsResponse> {

        let requestor: ListRequestor

        init(requestor: ListRequestor) {
            self.requestor = requestor
        }

        override func complete(response: PokemonsResponse?) {
            requestor.got(pokemons: response?.results ?? [])
        }
    }

    class MovesResponseHandler: ResponseHandler<MovesResponse> {

        let requestor: ListRequestor

        init(requestor: ListRequestor) {
            self.requestor = requestor
        }

        override func complete(response: MovesResponse?) {
            requestor.got(moves: response?.results ?? [])
        }
    }
}

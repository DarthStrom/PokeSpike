import Alamofire

class ResponseHandler<T> {

    var requestWrapper = RequestWrapper()

    func complete(response: T?) {}
}

class ListRequestor: ResponseHandler<PokemonResponse> {

    weak var logicDelegate: ListViewLogic?

    func request() {
        let request = PokemonRequest()
        requestWrapper.request(request, handler: self)
    }

    override func complete(response: PokemonResponse?) {
        logicDelegate?.onSuccess(pokemons: response?.results, moves: nil)
    }
}

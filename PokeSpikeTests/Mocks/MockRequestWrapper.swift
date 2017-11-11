import Moxie
@testable import PokeSpike

class MockRequestWrapper: RequestWrapper, Mock {
    var moxie = Moxie()

    override func request<T: Codable>(_ request: PokeRequest, handler: ResponseHandler<T>) {
        record(function: "request", wasCalledWith: [request, handler])
    }
}

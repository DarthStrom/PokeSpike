import Alamofire
import CodableAlamofire

class RequestWrapper {
    let af = Alamofire.SessionManager()

    func request<T: Codable>(_ request: PokeRequest, handler: ResponseHandler<T>) {
        af.request(request.url).responseDecodableObject { (response: DataResponse<T>) in
            handler.complete(response: response.result.value)
        }
    }
}

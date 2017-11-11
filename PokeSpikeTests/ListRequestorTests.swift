import Quick
import Nimble
@testable import PokeSpike

class ListRequestorTests: QuickSpec {
    override func spec() {

        describe("ListRequestor") {

            var subject: ListRequestor!

            beforeEach {
                subject = ListRequestor()
            }

            describe("request") {

                var mockRequestWrapper: MockRequestWrapper!

                beforeEach {
                    mockRequestWrapper = MockRequestWrapper()
                    subject.requestWrapper = mockRequestWrapper

                    subject.request()
                }

                it("makes a pokemons request") {
                    expect(mockRequestWrapper.parameters(forFunction: "request", invocation: 1)[0]).to(beAKindOf(PokemonsRequest.self))
                }

                it("makes a moves request") {
                    expect(mockRequestWrapper.parameters(forFunction: "request", invocation: 2)[0]).to(beAKindOf(MovesRequest.self))
                }

                context("when the moves request is completed first") {

                    var movesHandler: ListRequestor.MovesResponseHandler!
                    var movesResponse: MovesResponse?
                    var mockLogic: MockListViewLogic?

                    beforeEach {
                        movesHandler = mockRequestWrapper.parameters(forFunction: "request", invocation: 2)[1] as! ListRequestor.MovesResponseHandler
                        movesResponse = MovesResponse(count: 2,
                                                      previous: nil,
                                                      results: [
                                                        Move(url: URL(string: "http://first.com")!,
                                                             name: "first"),
                                                        Move(url: URL(string: "http://second.com")!,
                                                             name: "second")],
                                                      next: nil)
                        mockLogic = MockListViewLogic()
                        subject.logicDelegate = mockLogic

                        movesHandler.complete(response: movesResponse)
                    }

                    it("populates the moves data") {
                        expect(subject.moves).to(equal(movesResponse?.results))
                    }

                    it("does not yet declare success on the delegate") {
                        expect(mockLogic?.invoked(function: "onSuccess")).to(beFalse())
                    }

                    context("then the pokemons request is completed") {

                        var pokemonHandler: ListRequestor.PokemonResponseHandler!
                        var pokemonsResponse: PokemonsResponse!

                        beforeEach {
                            pokemonHandler = mockRequestWrapper.parameters(forFunction: "request", invocation: 1)[1] as! ListRequestor.PokemonResponseHandler
                            pokemonsResponse = PokemonsResponse(count: 2,
                                                                previous: nil,
                                                                results: [
                                                                    Pokemon(url: URL(string: "http://one.com")!,
                                                                            name: "one"),
                                                                    Pokemon(url: URL(string: "http://two.com")!,
                                                                            name: "two")],
                                                                next: nil)

                            pokemonHandler.complete(response: pokemonsResponse)
                        }

                        it("populates the pokemons data") {
                            expect(subject.pokemons).to(equal(pokemonsResponse.results))
                        }

                        it("declares success on the delegate") {
                            let params = mockLogic?.parameters(forFunction: "onSuccess")
                            expect(params?[0] as? [Pokemon]).to(equal(subject.pokemons))
                            expect(params?[1] as? [Move]).to(equal(subject.moves))
                        }
                    }
                }

                context("when the pokemons request is completed first") {

                    var pokemonHandler: ListRequestor.PokemonResponseHandler!
                    var pokemonsResponse: PokemonsResponse?
                    var mockLogic: MockListViewLogic?

                    beforeEach {
                        pokemonHandler = mockRequestWrapper.parameters(forFunction: "request", invocation: 1)[1] as! ListRequestor.PokemonResponseHandler
                        pokemonsResponse = PokemonsResponse(count: 2,
                                                            previous: nil,
                                                            results: [
                                                                Pokemon(url: URL(string: "http://one.com")!,
                                                                        name: "one"),
                                                                Pokemon(url: URL(string: "http://two.com")!,
                                                                        name: "two")],
                                                            next: nil)
                        mockLogic = MockListViewLogic()
                        subject.logicDelegate = mockLogic

                        pokemonHandler.complete(response: pokemonsResponse)
                    }

                    it("populates the pokemons data") {
                        expect(subject.pokemons).to(equal(pokemonsResponse?.results))
                    }

                    it("does not yet declare success on the delegate") {
                        expect(mockLogic?.invoked(function: "onSuccess")).to(beFalse())
                    }

                    context("then the moves request is completed") {

                        var movesHandler: ListRequestor.MovesResponseHandler!
                        var movesResponse: MovesResponse?

                        beforeEach {
                            movesHandler = mockRequestWrapper.parameters(forFunction: "request", invocation: 2)[1] as! ListRequestor.MovesResponseHandler
                            movesResponse = MovesResponse(count: 2,
                                                          previous: nil,
                                                          results: [
                                                            Move(url: URL(string: "http://first.com")!,
                                                                 name: "first"),
                                                            Move(url: URL(string: "http://second.com")!,
                                                                 name: "second")],
                                                          next: nil)

                            movesHandler.complete(response: movesResponse)
                        }

                        it("populates the moves data") {
                            expect(subject.moves).to(equal(movesResponse?.results))
                        }

                        it("declares success on the delegate") {
                            let params = mockLogic?.parameters(forFunction: "onSuccess")
                            expect(params?[0] as? [Pokemon]).to(equal(subject.pokemons))
                            expect(params?[1] as? [Move]).to(equal(subject.moves))
                        }
                    }
                }
            }
        }
    }
}

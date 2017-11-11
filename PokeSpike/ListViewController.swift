import UIKit

protocol ViewDelegate: class {
    func onSuccess()
}

class ListViewController: UIViewController, ViewDelegate {
    @IBOutlet var pokemonList: UITableView!
    @IBOutlet var moveList: UITableView!

    var viewLogic = ListViewLogic()
    var pokemonListDataSource: PokemonListDataSource!
    var moveListDataSource: MoveListDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonListDataSource = PokemonListDataSource(viewLogic: viewLogic)
        moveListDataSource = MoveListDataSource(viewLogic: viewLogic)
        pokemonList.dataSource = pokemonListDataSource
        moveList.dataSource = moveListDataSource

        viewLogic.viewDelegate = self
        viewLogic.fetchLists()
    }

    func onSuccess() {
        pokemonList.reloadData()
        moveList.reloadData()
    }
}


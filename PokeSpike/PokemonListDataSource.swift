import UIKit

class PokemonListDataSource: NSObject, UITableViewDataSource {

    let viewLogic: ListViewLogic

    init(viewLogic: ListViewLogic) {
        self.viewLogic = viewLogic
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewLogic.pokemons?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListCell") as! PokemonListCell
        cell.name.text = viewLogic.pokemons?[indexPath.row].name ?? "??"
        return cell
    }
}

import UIKit

class MoveListDataSource: NSObject, UITableViewDataSource {

    let viewLogic: ListViewLogic

    init(viewLogic: ListViewLogic) {
        self.viewLogic = viewLogic
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewLogic.moves?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveListCell") as! MoveListCell
        cell.name.text = viewLogic.moves?[indexPath.row].name ?? "??"
        return cell
    }
}

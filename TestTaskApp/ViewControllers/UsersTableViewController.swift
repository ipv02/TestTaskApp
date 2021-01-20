

import UIKit

class UsersTableViewController: UITableViewController {
    
    private let urlStringUsers = "https://jsonplaceholder.typicode.com/users"
    
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchUsers(from: urlStringUsers) { users in
            DispatchQueue.main.async {
                self.users = users
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name

        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let user = users[indexPath.row].id
        let detailsVC = segue.destination as! DetailsCollectionViewController
    }
}

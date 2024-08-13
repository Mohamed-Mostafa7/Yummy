//
//  ListOrdersViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import UIKit

class ListOrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let orders: [Order] = [
        .init(id: "1", name: "San Adam", dish: .init(id: "1", name: "Koshari", description: "An Egyptian meal that consists of pasta, rice, tomato souce, and dakka.", image: "https://picsum.photos/100/200", calories: 456)),
        .init(id: "1", name: "Mazn Adam", dish: .init(id: "1", name: "Koshari", description: "An Egyptian meal that consists of pasta, rice, tomato souce, and dakka.", image: "https://picsum.photos/100/200", calories: 456)),
        .init(id: "1", name: "Mohamed Adam", dish: .init(id: "1", name: "Koshari", description: "An Egyptian meal that consists of pasta, rice, tomato souce, and dakka.", image: "https://picsum.photos/100/200", calories: 456)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Orders"
        registerCells()
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }


}

// tableView data source and delegate
extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailsViewController.instantiate()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}

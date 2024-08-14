//
//  ListDishesViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import UIKit

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: DishCategory!
    var dishes: [Dish] = [
        .init(id: "1", name: "Garri", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "1", name: "Indomie", description: "This is I have ever tasted in my life", image: "https://picsum.photos/100/200", calories: 134),
        .init(id: "1", name: "Pizza", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 1424),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = category.title
        registerCells()
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }

}

extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailsViewController.instantiate()
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

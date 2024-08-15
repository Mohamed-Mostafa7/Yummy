//
//  ListDishesViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import UIKit
import ProgressHUD

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: DishCategory!
    var dishes: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = category.title
        registerCells()
        ProgressHUD.animate()
        
        NetworkService.shared.fetchCategorydishes(categoryId: category.id ?? "") { [weak self] result in
            switch result {
            case .success(let dishes):
                ProgressHUD.dismiss()
                self?.dishes = dishes
                self?.tableView.reloadData()
            case .failure(let error):
                ProgressHUD.error(error.localizedDescription)
            }
        }
        
        
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

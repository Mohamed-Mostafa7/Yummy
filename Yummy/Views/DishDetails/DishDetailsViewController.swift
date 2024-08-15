//
//  DishDetailsViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import UIKit
import ProgressHUD

class DishDetailsViewController: UIViewController {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDetails()
        
    }
    
    private func setupViewDetails() {
        dishImageView.kf.setImage(with: dish.image?.asURL)
        titleLabel.text = dish.name
        caloriesLabel.text = dish.formatedCalories
        descriptionLabel.text = dish.description
    }
    
    @IBAction func placeOrderButtonClicked(_ sender: UIButton) {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            ProgressHUD.error("Please Write a valid name")
            return
        }
        
        ProgressHUD.animate("Placing Order...")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { result in
            switch result {
            case.success(_):
                ProgressHUD.succeed("Your order has been recieved👨‍🍳")
            case .failure(let error):
                ProgressHUD.error(error.localizedDescription)
            }
        }
        
    }
    
}

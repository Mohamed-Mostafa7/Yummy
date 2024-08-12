//
//  DishDetailsViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import UIKit

class DishDetailsViewController: UIViewController {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func placeOrderButtonClicked(_ sender: UIButton) {
    }
    
}

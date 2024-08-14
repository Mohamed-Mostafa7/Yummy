//
//  CategoryCollectionViewCell.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 11/08/2024.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static var identifier = String(describing: CategoryCollectionViewCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(category: DishCategory) {
        categoryTitleLable.text = category.title
        categoryImageView.kf.setImage(with: category.image?.asURL)
    }

}

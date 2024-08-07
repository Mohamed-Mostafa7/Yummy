//
//  OnboardingCollectionViewCell.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 07/08/2024.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
  
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLable: UILabel!
    @IBOutlet weak var slideDescriptionLable: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLable.text = slide.title
        slideDescriptionLable.text = slide.description
    }
}

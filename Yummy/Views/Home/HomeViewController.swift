//
//  HomeViewController.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 11/08/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "1", name: "dish 1", image: "https://picsum.photos/100/200"),
        .init(id: "1", name: "dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "1", name: "dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "1", name: "dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "1", name: "dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var populars: [Dish] = [
        .init(id: "1", name: "Garri", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "1", name: "Indomie", description: "This is I have ever tasted in my life", image: "https://picsum.photos/100/200", calories: 134),
        .init(id: "1", name: "Pizza", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 1424),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
}

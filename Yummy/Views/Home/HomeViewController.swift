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
    @IBOutlet weak var specialsCollectinView: UICollectionView!
    
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
    
    var specials: [Dish] = [
        .init(id: "1", name: "Fried Plantain", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "1", name: "Indomie", description: "This is I have ever tasted in my life", image: "https://picsum.photos/100/200", calories: 134),
        .init(id: "1", name: "Pizza", description: "This is I have ever tested", image: "https://picsum.photos/100/200", calories: 1424),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        specialsCollectinView.delegate = self
        specialsCollectinView.dataSource = self
        
        NetworkService.shared.myFirstRequest { result in
            switch result {
            case .success(let data):
                for dish in data {
                    print(dish.name ?? "Not Found")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        registerCells()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialsCollectinView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }

}

//MARK: - Collection view delegate and data source.
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialsCollectinView:
            return specials.count
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
        case specialsCollectinView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailsViewController.instantiate()
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

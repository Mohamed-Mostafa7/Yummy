//
//  Dish.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 12/08/2024.
//

import Foundation

struct Dish: Codable {
    let id, name, description, image: String?
    let calories: Int?
    
    var formatedCalories: String {
        return "\(calories ?? 0) calories"
    }
}

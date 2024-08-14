//
//  AllDishes.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 14/08/2024.
//

import Foundation

struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
    
}

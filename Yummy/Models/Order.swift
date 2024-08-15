//
//  Order.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 13/08/2024.
//

import Foundation

struct Order: Codable {
    let id, name: String?
    let dish: Dish?
}

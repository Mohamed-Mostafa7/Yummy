//
//  APIResponse.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 14/08/2024.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}

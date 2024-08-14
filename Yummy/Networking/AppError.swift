//
//  AppError.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 14/08/2024.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be docoded."
        case .unknownError:
            return "Bro, I have no idea waht is going on."
        case .invalidUrl:
            return "Hey, give me a valid URL."
        case .serverError(let error):
            return error
        }
    }
}

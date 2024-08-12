//
//  String+Extension.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 11/08/2024.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}

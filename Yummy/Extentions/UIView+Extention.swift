//
//  UIView+Extention.swift
//  Yummy
//
//  Created by Mohamed Mostafa on 07/08/2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRaduis: CGFloat {
        get { return self.cornerRaduis }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

//
//  UIView+Utils.swift
//  mind
//
//  Created by minhazpanara
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import UIKit

extension UIView {
    func setCornerRadius(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

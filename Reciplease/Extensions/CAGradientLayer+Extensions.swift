//
//  CAGradientLayer+Extensions.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 19/07/2021.
//

import UIKit

extension CAGradientLayer {
    func implementShadowLayer(imageView: UIImageView) {
        colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        startPoint = CGPoint(x: 0, y: 0.70)
        endPoint = CGPoint(x: 0, y: 1)
        frame = imageView.bounds
        imageView.layer.mask = self
    }
}

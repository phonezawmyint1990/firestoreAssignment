//
//  CardView.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 25/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var img:UIImage = UIImage()
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        
        
        let iv = UIImageView(frame: layer.bounds)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = img
        iv.layer.cornerRadius = cornerRadius
        layer.addSublayer(iv.layer)
    }
    
}


//
//  Gradient.swift
//  MyAlarmApp
//
//  Created by Mark Witt on 5/29/20.
//  Copyright © 2020 Mark Witt. All rights reserved.
//

import Foundation
import UIKit

//youtube video on making a gradient
//https://www.youtube.com/watch?v=3gUNg3Jhjwohttps://www.youtube.com/watch?v=3gUNg3Jhjwo
extension UIView{
    func setColorGradientNight(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.5)
        gradientLayer.endPoint = CGPoint(x:0.5, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setColorGradientDay1(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x:1.0, y: -0.5)
            
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setColorGradientDay2(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x:0.0, y: -0.5)
            
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


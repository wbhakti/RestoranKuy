//
//  UIColor.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import UIKit

extension UIColor {
    static func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIColor {
    static var mainColor: UIColor {
        return RGBColor(red: 74, green: 199, blue: 238)
    }
}


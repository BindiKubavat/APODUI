//
//  RoundImage.swift
//  APODUI
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundImage: UIImageView {
    @IBInspectable var radius: Int = 10 {
        didSet {
            self.layer.cornerRadius = CGFloat(radius)
        }
    }
}

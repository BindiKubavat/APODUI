//
//  RecentCell.swift
//  APODUI
//
//  Created by Bindi Kubavat on 19/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import UIKit
import APODKit

class RecentCell: UICollectionViewCell {
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellLabel: UITextView!
    
    
    func configureCell(model: APODModel) {
        if let data = model.downloadedImage  {
        cellImage?.image = UIImage.init(data: data)
        }
        cellLabel?.text = model.explanation ?? ""
    }
}

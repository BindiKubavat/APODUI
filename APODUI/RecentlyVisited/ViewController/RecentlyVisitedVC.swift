//
//  RecentlyVisitedVC.swift
//  APODUI
//
//  Created by Bindi Kubavat on 19/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import UIKit
import APODKit

class RecentlyVisitedVC: UIViewController {
    @IBOutlet var imageCollection: UICollectionView!
    var savedImages: [APODModel]  = UserDefaults.standard.localApods.reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollection.dataSource = self
        imageCollection.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        savedImages = UserDefaults.standard.localApods.reversed()
        imageCollection.reloadData()
    }
}
extension RecentlyVisitedVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell",
                                                         for: indexPath) as? RecentCell {
            let model = savedImages[indexPath.item]
            cell.configureCell(model: model)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cvRect = collectionView.frame
        return CGSize(width: cvRect.width, height: cvRect.height)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageCollection.collectionViewLayout.invalidateLayout()
        imageCollection.layoutSubviews()
        imageCollection.reloadData()
    }
}

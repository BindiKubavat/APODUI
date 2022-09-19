//
//  APODViewModel.swift
//  APODUI
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import UIKit
import  APODKit
import NetworkKit

protocol APODViewModelDelegate {
    func hideShowBottomView(isHidden: Bool, multiplier: CGFloat)
    func initialiseViews()
    func showIndicator(shouldShow: Bool)
    func showError(er: String)
    func setData(ImageData: Data?, details: String, date: String)
}


class APODViewModel {
    let delegate: APODViewModelDelegate!
    var vcModel = APODVCModel()
    var apiManager: APODManager!
    
    init(delegate: APODViewModelDelegate) {
        self.delegate = delegate
        apiManager = APODManager.init(delegate: self)
        getImage(date: Date(), format: .fullDate)
        initalise()
    }
    func initalise() {
        delegate.initialiseViews()
    }
    func calendarDoneClicked(date: Date) {
        getImage(date: date, format: .fullDate2)
        delegate.hideShowBottomView(isHidden: true, multiplier: vcModel.hideMultiplier)
    }
    func swipeUpClicked() {
        delegate.hideShowBottomView(isHidden: false, multiplier: vcModel.showMultiplier)
    }
    func swipeDownClicked() {
        delegate.hideShowBottomView(isHidden: true, multiplier: vcModel.hideMultiplier)
    }
    
}

extension APODViewModel: APODManagerDelegate {
    func apodResponded(result: Result<APODModel, EnumAPIError>) {
        switch result {
        case .success(let model) :
            DispatchQueue.main.async {
                UserDefaults.standard.localApods = [model]
                self.vcModel.downloadedModels.append(model)
                self.showData(model: model)
            }
         case .failure(let error):
            delegate.showError(er: error.localizedDescription)
        }
         DispatchQueue.main.async {
            self.delegate.showIndicator(shouldShow: false)
        }
    }
    
    func getImage(date: Date, format: EnumDateFormats) {
          let dateString = String(date.description.split(separator: " ")[0])
        if let obj = vcModel.downloadedModels.filter({$0.date == dateString}).first {
            apodResponded(result: .success(obj))
        }
        else {
              downloadImage(date: date, format: format)
        }
    }
    
    func downloadImage(date: Date, format: EnumDateFormats) {
        delegate.showIndicator(shouldShow: true)
               apiManager.getAPOD(for: [.apiKey(key: "DEMO_KEY"), .date(date: date, format: format)])
    }
    
    func showData(model: APODModel) {
        delegate.setData(ImageData: model.downloadedImage , details: model.explanation ?? "", date: model.date ?? "")
    }
}


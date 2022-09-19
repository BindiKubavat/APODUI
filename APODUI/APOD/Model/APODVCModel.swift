//
//  APODVCModel.swift
//  APODUI
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import UIKit
import APODKit

class APODVCModel {
    init() {}
    
    var showMultiplier: CGFloat = 0.4
    var hideMultiplier: CGFloat = 0.0001
    var downloadedModels: [APODModel] = []
}

class LocalSavedModel: Codable {
     var explanation: String?
     var date: String?
     var downloadedImage: Data?
    
    init(model: APODModel) {
        self.explanation = model.explanation
        self.date = model.date
        self.downloadedImage = model.downloadedImage
    }
    
    func getAPIModel() -> APODModel {
        let model = APODModel()
        model.explanation = self.explanation
        model.date = self.date
        model.downloadedImage = self.downloadedImage
        
        return model
    }
    static func getAPIModels(model: [LocalSavedModel]) -> [APODModel] {
        let apiModels: [APODModel] = model.map({$0.getAPIModel()})
        return apiModels
    }
    static func getUIModels(model: [APODModel]) -> [LocalSavedModel] {
        let apiModels: [LocalSavedModel] = model.map({LocalSavedModel.init(model: $0)})
        return apiModels
    }
    
}

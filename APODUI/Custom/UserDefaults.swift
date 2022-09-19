//
//  UserDefaults.swift
//  APODUI
//
//  Created by Bindi Kubavat on 19/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import APODKit

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case localAPODs
    }
    
    var localApods: [APODModel] {
        get{
            let data = (self[.localAPODs] as? Data) ?? Data()
            let decodable = try? JSONDecoder.init().decode([LocalSavedModel].self, from: data)
            let apiModel = LocalSavedModel.getAPIModels(model: decodable ?? [])
            return apiModel
        }
        set {
            var savedModel = UserDefaults.standard.localApods
            if savedModel.count >= 10 {
                savedModel.removeLast(newValue.count)
            }
            for val in newValue {
                if !savedModel.contains(where: {$0.date == val.date}) {
                    savedModel.append(val)
                }
            }
            let uiModel = LocalSavedModel.getUIModels(model: savedModel)
            if let data = try? JSONEncoder.init().encode(uiModel) {
                self[.localAPODs] = data
            }
            }
        }
        
        
        subscript( key: UserDefaultsKeys) -> Any? {
        get {
        return UserDefaults.standard.value(forKey: key.rawValue)
        }
        set(newValue) {
        UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
        }
        
}

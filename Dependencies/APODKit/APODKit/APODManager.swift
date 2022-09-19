//
//  APODManager.swift
//  APODKit
//
//  Created by Bindi Kubavat on 17/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import NetworkKit

public protocol APODManagerDelegate {
    func apodResponded(result: Result<APODModel, EnumAPIError>)
}


public class APODManager: NetworkManagerDelegate {
    
    
    var delegate: APODManagerDelegate?
    var networkManager: NetworkManager!
    
    public init(delegate: APODManagerDelegate){
        self.delegate = delegate
        networkManager = NetworkManager.init(delegate: self)
    }
    
    public func getAPOD(for queries: [EnumQueryParam]){
        
        if  !EnumQueryParam.validateDateQuery(queries: queries) {
            delegate?.apodResponded(result: .failure(.dateOutOfRange))
        }
        let url = URL.generateURL(baseURL: Config.baseURL, path: [.planetary,.apod], query: queries)
        networkManager.makeAPICall(responseType: APODModel.self, requestType: .get, url: url)
    }
}
extension APODManager {
    public func serviceResponded(with result: Result<Codable, EnumAPIError>) {
        
        switch  result {
        case .success(let object):
            if  let val = object as? APODModel {
                getImageForModel(model: val, complition: { (model, er)  in
                    if let modelObj = model {
                        self.delegate?.apodResponded(result: .success(modelObj))
                    }else {
                        self.delegate?.apodResponded(result: .failure(er ?? .unableToDownloadImage))
                    }
                })
            }
        case .failure(let er) :
            self.delegate?.apodResponded(result: .failure(er))
        }
    }
    
    func getImageForModel(model: APODModel, complition: @escaping (APODModel?,EnumAPIError?) -> Void){
       let apiModel = model
        var imageUrl: String = ""
        if model.mediaType == "image" {
            imageUrl = model.url ?? ""
        }else {
            imageUrl = model.thumbnail ?? ""
        }
        networkManager.downloadImage(url: imageUrl) { (data, error) in
            guard error == nil else{
                apiModel.downloadedImage = nil
                apiModel.errorMessage = "Unable to download image"
                complition(apiModel, .unableToDownloadImage)
                return
            }
            apiModel.downloadedImage = data
            apiModel.errorMessage = ""
            complition(apiModel, nil)
        }
    }
}

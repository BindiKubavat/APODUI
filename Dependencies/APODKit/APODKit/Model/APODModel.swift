//
//  APODModel.swift
//  APODKit
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import UIKit

public class APODModel: Codable{
    public init() {}
    var copyright: String?
    public var explanation: String?
    var hdurl: String?
    var mediaType, serviceVersion, title: String?
    var url: String?
    public   var thumbnail, date: String?
    public  var downloadedImage: Data?
    public  var  errorMessage = ""
    
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case thumbnail = "thumbnail_url"
        case title, url
    }
    
}

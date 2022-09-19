//
//  URLExtension.swift
//  APODKit
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

extension URL {
    
    static func generateURL(baseURL:String, path: [EnumPath], query:[EnumQueryParam]) -> String {
        var finalQuery = baseURL
        finalQuery = finalQuery + "/" + EnumPath.getPaths(path: path) + "?" + EnumQueryParam.getQueries(inputQuery:query)
        return finalQuery
    }
    
    
}

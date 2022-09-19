//
//  PathGenerator.swift
//  APODKit
//
//  Created by Bindi Kubavat on 17/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

public enum EnumPath: String {
    case planetary = "planetary"
    case apod = "apod"
}
extension EnumPath  {
    static func getPaths(path: [EnumPath]) -> String {
        return path.map({$0.rawValue}).joined(separator: "/")
     }
}

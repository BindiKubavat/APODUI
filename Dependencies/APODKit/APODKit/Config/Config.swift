//
//  Config.swift
//  APODKit
//
//  Created by Bindi Kubavat on 17/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

public class Config {
    public init(){}
    
    public static let baseURL = "https://api.nasa.gov"
    static let apodStartDate = Date.getDate(inputString: "1995-06-16", format: .yyyymmddDashSaperated) ?? Date()
}

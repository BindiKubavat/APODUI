//
//  QueryParam.swift
//  APODKit
//
//  Created by Bindi Kubavat on 17/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

public enum EnumQueryParam {
    case apiKey(key: String = "DEMO_KEY")
    case date(date: Date, format: EnumDateFormats)
}

extension EnumQueryParam {
    
    static func getQueries(inputQuery: [EnumQueryParam]) -> String {
        return inputQuery.map{ val in
            switch val {
            case apiKey(key: let key) : return "api_key=" + key
            case .date(date: let dateVal, format: _):
             let dateString = String(dateVal.description.split(separator: " ")[0])
             print("subString ======")
                   print(dateString)
              return "date=" + dateString
            }
        }.joined(separator: "&")
    }
    
    static func containsDateParam(inputQuery: [EnumQueryParam]) -> (Bool, Date) {
        var containingDate: Date = Date.init()
        let contains =  inputQuery.contains { (type1) -> Bool in
            switch type1 {
            case .date(date: let date, format: _):
                containingDate = date
                return true
            default: return false
            }
        }
        
        return (contains, containingDate)
    }
    
    static func validateDateQuery(queries: [EnumQueryParam]) -> Bool{
        var isValid = true
        let (contains, date) = EnumQueryParam.containsDateParam(inputQuery: queries)
               if contains {
                   if !date.isBetween(oldDate: Config.apodStartDate, and: Date.init()) {
                       isValid = false
                   }
               }
           return isValid
        }
}

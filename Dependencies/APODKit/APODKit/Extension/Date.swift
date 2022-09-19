//
//  Date.swift
//  APODKit
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation

public enum EnumDateFormats: String {
    case yyyymmddDashSaperated = "yyyy-MM-dd"
    case fullDate = " yyyy-MM-dd HH:mm:ss +0000"
    case fullDate2 = " yyyy-MM-dd HH:mm:ssZ"
    case fullDate3 = " yyyy-MM-dd HH:mm:ss Z"
}

extension Date {
    
    static func getDate(inputString: String, format: EnumDateFormats) -> Date? {
        let formater = DateFormatter.init()
        formater.dateFormat = format.rawValue
        let date = formater.date(from: inputString)
        return date
    }
    
    static func getDate(inputDate: Date, format: EnumDateFormats) -> String? {
           let formater = DateFormatter.init()
           formater.dateFormat = format.rawValue
          let date = formater.string(from: inputDate)
           return date
       }
    
    func isBetween(oldDate: Date, and newDate: Date) -> Bool {
        let isValid = (oldDate...newDate).contains(self)
        return isValid
    }
    
  static  func formattedDateFromString(dateString: String, currentFormat: EnumDateFormats,  withOutputFormat format: EnumDateFormats) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = currentFormat.rawValue

        let date = inputFormatter.date(from: dateString) ?? Date()
        print(date)
          let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format.rawValue

            return outputFormatter.string(from: date)
    }
}

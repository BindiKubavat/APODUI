//
//  APODDateVC.swift
//  APODUI
//
//  Created by Bindi Kubavat on 18/09/22.
//  Copyright © 2022 Nasa. All rights reserved.
//

import Foundation
import UIKit

extension APODVC {
    
    func setDatePicker() {
        datePicker.maximumDate = Date()
    }
    
    func refreshDatePickerToCurrentDate(){
        refreshDatePicker(to: Date())
    }
    
    func refreshDatePicker(to date: Date) {
        datePicker.date = date
    }
}

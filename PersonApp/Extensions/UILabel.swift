//
//  UILabel.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//
import Foundation
import UIKit

extension UILabel {
    
    func convertStrToDate(date:String?) {
    
        let date = Date(timeIntervalSince1970: Double(date!)!/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm"
        self.text = dateFormatter.string(from: date)
    }
}

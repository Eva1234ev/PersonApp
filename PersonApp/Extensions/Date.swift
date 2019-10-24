//
//  Date.swift
//  PersonApp
//
//  Created by Eva on 10/23/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit


    extension Date {
        var millisecondsSince1970:Int64 {
            return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
        }

    }


//
//  Encodable.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
}

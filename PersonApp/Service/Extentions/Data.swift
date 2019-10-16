//
//  Data.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import Foundation
typealias CompletionHandler<T> = (_ data: T)->()
typealias ErrorHandler = (_ error: Error?)->()
extension Data {
    
    func decodeToJSON<T: Decodable>(with type: T.Type, completionHandler: CompletionHandler<T>, errorHandler: ErrorHandler) {
        do {
            let json = try JSONDecoder().decode(T.self, from: self)
            completionHandler(json)
        } catch {
            errorHandler(error)
        }
    }
    
}

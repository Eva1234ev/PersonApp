//
//  RequestManager.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

final class RequestManager: NSObject {
    

    private static let usersPath = "http://test.php-cd.attractgroup.com/test.json"
    
    static func getPersons(completionHandler: @escaping CompletionHandler<Persons>, errorHandler: @escaping ErrorHandler) {
        let url = URL(string: usersPath)!
        URLSession.shared.executeTask(with: url, httpMethod: .get, completionHandler: { (data, response, error) in
            check(data: data, response: response, error: error, completionHandler: { (data) in
                
                data?.decodeToJSON(with: Persons.self, completionHandler: completionHandler, errorHandler: errorHandler)
                
            }, errorHandler: errorHandler, repeatHendler: {
               
                getPersons(completionHandler: completionHandler, errorHandler: errorHandler)
               
            })
        }).resume()
    }
    
    
    private static func check(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Data?) -> Void, errorHandler: ErrorHandler, repeatHendler: (()->())?) {
       // if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200, statusCode < 300 {
            completionHandler(data)
//        } else if let error = error as? URLError, ((error.code == .notConnectedToInternet) || (error.code == .networkConnectionLost)) {
//            errorHandler(nil)
//        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 423 {
//            errorHandler(nil)
//
//        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 401 {
//            if let repeatHendler = repeatHendler {
//                repeatHendler()
//            } else {
//                errorHandler(CustomError(errorDescription: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
//            }
//        } else if let error = error {
//            errorHandler(error)
//        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//            errorHandler(CustomError(errorDescription: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
//        } else {
//            errorHandler(CustomError(errorDescription: "Unknown Error"))
//        }
}
    
}

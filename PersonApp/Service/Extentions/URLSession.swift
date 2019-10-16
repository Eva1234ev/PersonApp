//
//  URLSession.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//
import Foundation

extension URLSession {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    func executeTask<T: Codable>(with url: URL, httpMethod: HTTPMethod?, body: T?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        if let httpMethod = httpMethod {
            request.httpMethod = httpMethod.rawValue
        }
        if let body = body {
            request.httpBody = body.toJSONData()
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        }
        return self.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        }
    }
    
    func executeTask(with url: URL, httpMethod: HTTPMethod?,  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let emptyModel: EmptyModel? = nil
        return executeTask(with: url, httpMethod: httpMethod, body: emptyModel, completionHandler: completionHandler)
    }
    
    private struct EmptyModel: Codable {
        
    }
    
}



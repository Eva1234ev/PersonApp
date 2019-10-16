//
//  Error.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//
import Foundation

public enum AuthConfirmResponseError: Int, Error {
    case err400 = 400
    case err403 = 403
    case err404 = 404
}

extension AuthConfirmResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .err400:
            return "An error occurred while decoding data 400"
        case .err403:
            return "An error occurred while decoding data 403"
        case .err404:
            return "An error occurred while decoding data 404"
        }
    }
}

struct CustomError: LocalizedError {
    let errorDescription: String?
}

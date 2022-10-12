//
//  File.swift
//  
//
//  Created by Freddy Plaz on 12.10.22.
//

import Foundation


public enum APIError: CustomNSError{
    case invalidURL
    case invalidResponseType
    case httpsStatusCodeFailed(statusCode: Int, error: ErrorResponse?)
    
    public static var errorDomain: String {
        "StocksAPI"
    }
    
    public var errorCode: Int {
        switch self {
        case .invalidURL: return 0
        case .invalidResponseType: return 1
        case .httpsStatusCodeFailed: return 2
        }
    }
    
    public var errorUserInfo: [String : Any] {
        let text: String
        
        switch self {
            case .invalidURL: text = "Invalid URL"
            case .invalidResponseType: text = "Invalid URL"
            case let .httpsStatusCodeFailed(statusCode, error):
                if let error = error {
                    text = "Error: Status Code: \(statusCode), message: \(error.description)"
                } else {
                    text = "Error: Status Code: \(statusCode)"
                }
        }
        return [NSLocalizedDescriptionKey: text]
    }
}

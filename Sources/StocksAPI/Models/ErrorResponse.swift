//
//  File.swift
//  
//
//  Created by Freddy Plaz on 09.10.22.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: String
    public let description: String
    
    init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}

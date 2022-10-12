//
//  File.swift
//  
//
//  Created by Freddy Plaz on 11.10.22.
//

import Foundation

public struct SearchTickersResponse: Decodable {
    public let data: [Ticker]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case quotes
        case finance
    }
    
    enum FinanceKeys: CodingKey {
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decodeIfPresent([Ticker].self, forKey: .quotes)
        self.error = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .finance).decodeIfPresent(ErrorResponse.self, forKey: .error)
    }
}

public struct Ticker: Codable, Identifiable, Hashable, Equatable {
    public let id = UUID()
    
    public let symbol: String?
    public let quoteType: String?
    public let shortname: String?
    public let longname: String?
    public let sector: String?
    public let industry: String?
    public let exchDisp: String?
    
    init(symbol: String?, quoteType: String?, shortname: String?, longname: String?, sector: String?, industry: String?, exchDisp: String?) {
        self.symbol = symbol
        self.quoteType = quoteType
        self.shortname = shortname
        self.longname = longname
        self.sector = sector
        self.industry = industry
        self.exchDisp = exchDisp
    }
    
}

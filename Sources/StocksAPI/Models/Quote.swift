//
//  File.swift
//  
//
//  Created by Freddy Plaz on 09.10.22.
//

import Foundation

public struct QuoteResponse: Decodable {
    
    public let data: [Quote]?
    public let error: ErrorResponse?

    enum CodingKeys: CodingKey {
        case quoteResponse
        case finance
    }
    
    enum ResponseKeys: CodingKey {
        case result
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let quoteResponseContainer = try? container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .quoteResponse) {
            self.data = try? quoteResponseContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try? quoteResponseContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        
        } else if let financeContainer = try? container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .finance) {
            self.data = try? financeContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try? financeContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else {
            self.data = nil
            self.error = nil
        }
    }
    
}

public struct Quote: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let currency: String?
    public let marketState: String?
    public let fullExchangeName: String?
    public let displayName: String?
    public let symbol: String?
    public let regularMarketPrice: Double?
    public let regularMarketChange: Double?
    public let regularMarketChangePercent: Double?
    public let regularMarketChangePreviousClose: Double?
    
    public let postMarketPrice: Double?
    public let postMarketChange: Double?
    
    public let regularMarketOpen: Double?
    public let regularMarketDayHigh: Double?
    public let regularMarketDayLow: Double?
    
    public let regularMarketVolume: Double?
    public let trailingPE: Double?
    public let marketCap: Double?
    
    public let fiftyTwoWeekLow: Double?
    public let fiftyTwoWeekHigh: Double?
    public let averageDailyVolume3Month: Double?
    
    public let trailingAnnualDividendYield: Double?
    public let epsTrailingTwelveMonths: Double?
    
    init(currency: String?, marketState: String?, fullExchangeName: String?, displayName: String?, symbol: String?, regularMarketPrice: Double?, regularMarketChange: Double?, regularMarketChangePercent: Double?, regularMarketChangePreviousClose: Double?, postMarketPrice: Double?, postMarketChange: Double?, regularMarketOpen: Double?, regularMarketDayHigh: Double?, regularMarketDayLow: Double?, regularMarketVolume: Double?, trailingPE: Double?, marketCap: Double?, fiftyTwoWeekLow: Double?, fiftyTwoWeekHigh: Double?, averageDailyVolume3Month: Double?, trailingAnnualDividendYield: Double?, epsTrailingTwelveMonths: Double?) {
        self.currency = currency
        self.marketState = marketState
        self.fullExchangeName = fullExchangeName
        self.displayName = displayName
        self.symbol = symbol
        self.regularMarketPrice = regularMarketPrice
        self.regularMarketChange = regularMarketChange
        self.regularMarketChangePercent = regularMarketChangePercent
        self.regularMarketChangePreviousClose = regularMarketChangePreviousClose
        self.postMarketPrice = postMarketPrice
        self.postMarketChange = postMarketChange
        self.regularMarketOpen = regularMarketOpen
        self.regularMarketDayHigh = regularMarketDayHigh
        self.regularMarketDayLow = regularMarketDayLow
        self.regularMarketVolume = regularMarketVolume
        self.trailingPE = trailingPE
        self.marketCap = marketCap
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.averageDailyVolume3Month = averageDailyVolume3Month
        self.trailingAnnualDividendYield = trailingAnnualDividendYield
        self.epsTrailingTwelveMonths = epsTrailingTwelveMonths
    }
    
}

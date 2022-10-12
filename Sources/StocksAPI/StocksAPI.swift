import Foundation



public struct StocksAPI {
    public let text = "Hello, World!"
    private let session = URLSession.shared
    private let jsonDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    public let baseURL = "https://query1.finance.yahoo.com"

    public init() {
    }
    
    public func fetchChartData(symbol: String, range: ChartRange) async throws -> ChartData? {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v8/finance/chart/\(symbol)") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [
            .init(name: "range", value: range.rawValue),
            .init(name: "interval", value: range.interval),
            .init(name: "indicators", value: "quote"),
            .init(name: "includeTimestamp", value: "true")
        ]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (ChartResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpsStatusCodeFailed(statusCode: statusCode, error: error)
        }
        return response.data?.first

    }
    
    public func searchTickers(query: String, IsEquityTypeOnly: Bool = true) async throws -> [Ticker] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v1/finance/search") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [
            .init(name: "q", value: query),
            .init(name: "quotewCount", value: "20"),
            .init(name: "lang", value: "en-US"),
        ]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (SearchTickersResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpsStatusCodeFailed(statusCode: statusCode, error: error)
        }
        
        if IsEquityTypeOnly {
            return (response.data ?? [])
                .filter { ($0.quoteType ?? "").localizedCaseInsensitiveCompare("equity") == .orderedSame}
        } else {
            return response.data ?? []
        }
        
    }
    
    public func fetchQuotes(symbols: String) async throws -> [Quote] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v7/finance/quote") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [.init(name: "symbols", value: symbols)]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (QuoteResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpsStatusCodeFailed(statusCode: statusCode, error: error)
        }
        return response.data ?? []
    }
    
    private func fetch<D: Decodable>(url: URL) async throws -> (D,  Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validateHttpResponse(response)
        return (try jsonDecoder().decode(D.self, from: data), statusCode)
    }
    
    private func validateHttpResponse(_ response: URLResponse) throws -> Int {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponseType
        }
        
        guard 200...299 ~= httpResponse.statusCode ||
                400...499 ~= httpResponse.statusCode
        else{
            throw APIError.httpsStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
        }
        return httpResponse.statusCode
    }
}

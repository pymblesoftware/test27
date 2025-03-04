//
//  CryptoAPI.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//



import Foundation

class CryptoAPI {
    static let shared = CryptoAPI()
    private let cache = URLCache.shared
    private let cacheExpiry: TimeInterval = 86400 // 1 day

    // API Endpoint
    private let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false"

    func fetchCryptoPrices(completion: @escaping (Result<[Crypto], Error>) -> Void) {
        guard let requestURL = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400)))
            return
        }

        // Check cache first
        let request = URLRequest(url: requestURL)
        if let cachedResponse = cache.cachedResponse(for: request) {
            do {
                let decodedData = try JSONDecoder().decode([Crypto].self, from: cachedResponse.data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
                return
            } catch {
                print("Failed to decode cached data")
            }
        }

        // Fetch from API if not cached
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data, let response = response else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Invalid response", code: 500)))
                }
                return
            }

            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)

                // Store in cache
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedResponse, for: request)

                DispatchQueue.main.async {
                    completion(.success(cryptos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

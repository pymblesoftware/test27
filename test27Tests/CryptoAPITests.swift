//
//  CryptoAPITests.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//
//
// More like integration tests than unit tests.
// I shut down a .NET developer by running integration tests from XCTest when he was saying it must be the app..
// "Oh look 400s and 500s" ... "yeah but, yeah but... Okay try it now".
//


import XCTest
@testable import test27

class CryptoAPITests: XCTestCase {
    
    func testFetchCryptoPrices() {
        let expectation = self.expectation(description: "Fetching Crypto Data")
        
        CryptoAPI.shared.fetchCryptoPrices { result in
            switch result {
            case .success(let cryptos):
                XCTAssertFalse(cryptos.isEmpty, "Crypto list should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch data: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCacheStorage() {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false")!
        let request = URLRequest(url: url)
        let mockResponse = CachedURLResponse(response: URLResponse(), data: Data())

        URLCache.shared.storeCachedResponse(mockResponse, for: request)

        let cachedResponse = URLCache.shared.cachedResponse(for: request)
        XCTAssertNotNil(cachedResponse, "Cache should store the response")
    }
}

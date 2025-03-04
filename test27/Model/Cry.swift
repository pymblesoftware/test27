//
//  Crypto.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//


import Foundation

// Model for the cryptocurrency response
struct Crypto: Identifiable, Codable {
    let id: String
    let name: String
    let current_price: Double
    let symbol: String
    let image: String
}

// Response structure
struct CryptoResponse: Codable {
    let cryptos: [Crypto]
    
    enum CodingKeys: String, CodingKey {
        case cryptos = "coins"
    }
}

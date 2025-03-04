//
//  ViewMocdel.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    @Published var showError = false
    @Published var errorMessage: String?

    func fetchCryptos() {
        CryptoAPI.shared.fetchCryptoPrices { result in
            switch result {
            case .success(let data):
                self.cryptos = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
    }
}

//
//  ContentView.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = CryptoViewModel()

    var body: some View {
        
        NavigationView {
                   List(viewModel.cryptos) { crypto in
                       HStack {
                           AsyncImage(url: URL(string: crypto.image)) { image in
                               image.resizable()
                           } placeholder: {
                               ProgressView()
                           }
                           .frame(width: 40, height: 40)
                           .clipShape(Circle())

                           VStack(alignment: .leading) {
                               Text(crypto.name)
                                   .font(.headline)
                               Text(crypto.symbol.uppercased())
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                           }

                           Spacer()

                           Text("$\(crypto.current_price, specifier: "%.2f")")
                               .font(.headline)
                       }
                   }
                   .navigationTitle("Top 5 Cryptos")
                   .onAppear {
                       viewModel.fetchCryptos()
                   }
                   .alert(isPresented: $viewModel.showError) {
                       Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                   }
               }
           }
    }

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

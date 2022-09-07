//
//  CryptoManager.swift
//  CryptoCurrencies
//
//  Created by Alexander Shpin on 07.09.2022.
//

import Foundation

protocol CryptoManagerDelegate {
    func didFailWithError(error: Error)
    func updateCurrency(crypto: CryptoModel)
}

struct CryptoManager {
    
    let currencies = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let key = "0711AF29-B661-4116-B730-B85D8166D618"
    
    var delegate: CryptoManagerDelegate?
    
    func getCurrency(currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(key)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, reponse, error in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    if let crypto = parseJSON(safeData) {
                        self.delegate?.updateCurrency(crypto: crypto)
                    }
                }
            }
            
            task.resume()
        }

    }

    func parseJSON(_ currencyData: Data) -> CryptoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CryptoModel.self, from: currencyData)
            let rate = decodedData.rate
            
            let currency = CryptoModel(rate: rate)
            
            return currency
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

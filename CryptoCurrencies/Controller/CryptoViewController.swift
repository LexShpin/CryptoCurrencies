//
//  ViewController.swift
//  CryptoCurrencies
//
//  Created by Alexander Shpin on 07.09.2022.
//

import UIKit

class CryptoViewController: UIViewController {
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    var cryptoManager = CryptoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        cryptoManager.delegate = self
        rateLabel.adjustsFontSizeToFitWidth = true
    }


}

extension CryptoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cryptoManager.currencies.count
    }
}

extension CryptoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = cryptoManager.currencies[row]
        currencyLabel.text = currency
        cryptoManager.getCurrency(currency: currency)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cryptoManager.currencies[row]
    }
}

extension CryptoViewController: CryptoManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
        return
    }
    func updateCurrency(crypto: CryptoModel) {
        DispatchQueue.main.async {
            self.rateLabel.text = String(format: "%.1f", crypto.rate)
        }
    }
}

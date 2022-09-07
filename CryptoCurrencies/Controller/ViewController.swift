//
//  ViewController.swift
//  CryptoCurrencies
//
//  Created by Alexander Shpin on 07.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    var cryptoManager = CryptoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }


}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cryptoManager.currencies.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = cryptoManager.currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cryptoManager.currencies[row]
    }
}

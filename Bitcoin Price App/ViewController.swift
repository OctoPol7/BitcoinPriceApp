//
//  ViewController.swift
//  Bitcoin Price App
//
//  Created by laptop on 2022-11-07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var eurLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBAction func refreshTapped(_ sender: Any) {
        getPrice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        getPrice()
    }
    
    func getPrice() {
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            URLSession.shared.dataTask(with: url) { ( data, response, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as?
                        [String:Double] {
                    
                        DispatchQueue.main.async {
                            if let usdPrice = json["USD"] {
                                self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD")
                            }
                            if let eurPrice = json["EUR"] {
                                self.eurLabel.text = self.doubleToMoneyString(price: eurPrice, currencyCode: "EUR")
                            }
                            if let jpyPrice = json["JPY"] {
                                self.jpyLabel.text = self.doubleToMoneyString(price: jpyPrice, currencyCode: "JPY")
                            }
                        
                        }
                    }
                }else {
                    print("Something went wrong!")
                }
            }.resume()
        }

    }
    
    func doubleToMoneyString(price: Double, currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        
        return priceString
    }

}


//
//  PricesViewController.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/05.
//

import UIKit
import Alamofire

class PricesViewController: UITableViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var prices: [priceResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PriceCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "PriceCell")
        tableView.rowHeight = 80
        self.fetchPriceData(completionHandler: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(result):
                    self.prices = result
                case let .failure(error):
                    debugPrint("Error: \(error)")
                }
        })
    }
    
    private func fetchPriceData(completionHandler: @escaping (Result<[priceResponse], Error>) -> Void) {
        let url = "https://api.coinpaprika.com/v1/tickers"
        
        AF.request(url, method: .get)
            .responseData(completionHandler: { response in
                debugPrint(response.result)
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([priceResponse].self, from: data)
                        
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as? PriceCell else { return UITableViewCell()}
        
        let imageURL = URL(string: "https://cryptoicon-api.vercel.app/api/icon/\(prices[indexPath.row].symbol.lowercased())")
        
        cell.coinNameLabel.text = prices[indexPath.item].name
        cell.symbolImageView.kf.setImage(with: imageURL)
        cell.priceLabel.text = "\(prices[indexPath.row].price)"
        cell.percentageLabel.text = "\(prices[indexPath.row].percentage)%"
        cell.percentageLabel.textColor = prices[indexPath.row].percentage > 0 ? UIColor.red : prices[indexPath.row].percentage == 0 ? UIColor.white : UIColor.blue

        
        return cell
    }
}

//
//  CoinDetailViewController.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/06.
//

import UIKit
import Alamofire

class CoinDetailViewController: UIViewController {
    
    var coinId: String?
    var coinDetail: CoinDetail? {
        didSet {
            guard let detail = self.coinDetail else { return }
            self.pageTitle.text = "about \(detail.name)"
            self.coinDesc.text = detail.description
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var coinDesc: UITextView!
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CoinLinkCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "CoinLinkCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50
        self.fetchCoinDetailData(completionHandler: { [weak self] result in
            guard let self = self else { return }
                        
            switch result {
            case let .success(result):
                self.coinDetail = result
            case let .failure(error):
                debugPrint("Error: \(error)")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
            
    private func fetchCoinDetailData(completionHandler: @escaping (Result<CoinDetail, Error>) -> Void) {
        let url = "https://api.coinpaprika.com/v1/coins/\(self.coinId!)"
        
        AF.request(url, method: .get)
            .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CoinDetail.self, from: data)
                        
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
}

extension CoinDetailViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = coinDetail?.links.count else { return 0 }
        return count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinLinkCell", for: indexPath) as? CoinLinkCell else { return UITableViewCell() }
        guard let detail = coinDetail else { return UITableViewCell()}
        
        cell.link = detail.links[indexPath.row].url
        cell.linkLabel.text = detail.links[indexPath.row].type
        cell.linkLabel.textColor = .black
        return cell
    }
}

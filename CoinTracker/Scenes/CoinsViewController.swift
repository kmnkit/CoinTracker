//
//  CoinsViewController.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/05.
//

import UIKit
import Alamofire
import Kingfisher


class CoinsViewController: UICollectionViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var cellsPerRow: CGFloat = 3
    let cellMargin: CGFloat = 10
    
    var coins: [Coin] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CoinCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "CoinCell")
        
        self.indicator.startAnimating()
        self.fetchCoinsData(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            switch result {
            case let .success(result):
                self.coins = result                
            case let .failure(error):
                debugPrint("Error: \(error)")
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as? CoinCell else { return UICollectionViewCell() }
        
        let imageURL = URL(string: "https://cryptoicon-api.vercel.app/api/icon/\(coins[indexPath.item].symbol.lowercased())")
        
        cell.coinSymbolLabel.text = coins[indexPath.item].name
        cell.coinSymbolImageView.kf.setImage(with: imageURL)
                
        cell.contentView.layer.cornerRadius = 2.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        return cell
    }
    
    private func fetchCoinsData(completionHandler: @escaping (Result<[Coin], Error>) -> Void) {
        let url = "https://api.coinpaprika.com/v1/coins"
        
        AF.request(url, method: .get)
            .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Coin].self, from: data)
                        completionHandler(.success(result))
                        
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CoinDetailViewController") as? CoinDetailViewController else { return }
        
        detailViewController.coinId = self.coins[indexPath.item].id
        detailViewController.title = self.coins[indexPath.item].name
        self.show(detailViewController, sender: nil)
    }
}

extension CoinsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width - 4 * cellMargin) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.tabBarItem.selectedImage = UIImage(systemName: "bitcoinsign.circle.fill")
        
        let nibName = UINib(nibName: "CoinCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "CoinCell")
        self.indicator.stopAnimating()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as? CoinCell else { return UICollectionViewCell() }
        let imageURL = URL(string: "https://cryptoicon-api.vercel.app/api/icon/btc")
        cell.coinSymbolLabel.text = "BitCoin"
        cell.coinSymbolImageView.kf.setImage(with: imageURL)
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        return cell
    }
    
}

extension CoinsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width - 4 * cellMargin) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

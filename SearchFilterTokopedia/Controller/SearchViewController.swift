//
//  SearchViewController.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 16/11/20.
//

import UIKit
import SwiftyJSON
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    var params = Parameter()
    private let apiRequest = APIRequest()
    private var searchResults = [JSON](){
        didSet {
            productCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        fetchData(params: params)
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    func registerNib() {
        self.title = "Search"
        let nib = UINib(nibName: ProductCell.nibName, bundle: nil)
        productCollectionView?.register(nib, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
    }
    func fetchData(params: Parameter){
        apiRequest.filter(params: params, completionHandler: {
            [weak self] results, error in
            if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            
            self?.searchResults.append(contentsOf: results)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterViewController {
            vc.delegate = self
            vc.params = params
        }
    }
}
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier,
                                                         for: indexPath) as? ProductCell {
            if let url = searchResults[indexPath.row]["image_uri"].string {
                apiRequest.fetchImage(url: url, completionHandler: { image, _ in
                    cell.configureCell(image: image!,
                                       name: self.searchResults[indexPath.row]["name"].stringValue,
                                       price: self.searchResults[indexPath.row]["price"].stringValue)
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat =  30
            let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            params.start = String(Int(params.start)! + 10)
            fetchData(params: params)
        }
    }
    
}
protocol FilterDelegate : class {
    func setParamData(param: Parameter)
}
extension SearchViewController: FilterDelegate {
    func setParamData(param: Parameter) {
        params = param
        searchResults.removeAll()
        fetchData(params: params)
    }
}

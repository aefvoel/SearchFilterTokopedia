//
//  FilterViewController.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 16/11/20.
//

import UIKit

class FilterViewController: UIViewController {

    var tagsArray = [String](){
        didSet {
            typeCollectionView.reloadData()
        }
    }
    var type = [String]()
    var params: Parameter?
    var delegate: FilterDelegate?
    @IBOutlet weak var typeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tagsArray.removeAll()
        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }
    func setupView(){
        let nib = UINib(nibName: TypeCollectionViewCell.nibName, bundle: nil)
        typeCollectionView?.register(nib, forCellWithReuseIdentifier: TypeCollectionViewCell.reuseIdentifier)
        if let flowLayout = self.typeCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 144, height: 33)
        }
        if params?.official == true {
            tagsArray.append("Official Store")
        }
        
        if params?.fshop == "2" {
            tagsArray.append("Gold Merchant")
        }
        

    }
    @IBAction func closeButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyBtton(_ sender: UIButton) {
        params?.start = "0"
        delegate?.setParamData(param: params!)
        self.navigationController?.popViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShopTypeViewController {
            vc.delegate = self
            vc.params = params
        }
    }
    @objc func onRemoveType(_ sender: UIButton){
        tagsArray.remove(at: sender.tag)
        DispatchQueue.main.async {
            self.params?.fshop = self.tagsArray.contains("Gold Merchant") ? "2" : "1"
            self.params?.official = self.tagsArray.contains("Official Store") ? true : false
        }
    }
}
extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionViewCell.reuseIdentifier,
                                                         for: indexPath) as? TypeCollectionViewCell {
            cell.configureCell(label: tagsArray[indexPath.row])
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(self.onRemoveType), for: .touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
}
extension FilterViewController: FilterDelegate {
    func setParamData(param: Parameter) {
        params = param
        print(param)
    }
}


//
//  ProductCell.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 16/11/20.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    class var reuseIdentifier: String {
        return "ProductCell"
    }
    class var nibName: String {
        return "ProductCell"
    }
    func configureCell(image: UIImage, name: String, price: String) {
        self.productImage.image = image
        self.productName.text = name
        self.productPrice.text = price
    }

}

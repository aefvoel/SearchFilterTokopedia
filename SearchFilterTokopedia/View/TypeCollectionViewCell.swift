//
//  TypeCollectionViewCell.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 18/11/20.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var removeButton: RoundedButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    class var reuseIdentifier: String {
        return "TypeCell"
    }
    class var nibName: String {
        return "TypeCollectionViewCell"
    }
    func configureCell(label: String) {
        self.typeLabel.text = label
    }

}

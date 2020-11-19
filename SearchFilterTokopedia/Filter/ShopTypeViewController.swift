//
//  ShopTypeViewController.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 19/11/20.
//

import UIKit

class ShopTypeViewController: UIViewController {

    var params: Parameter?
    var delegate: FilterDelegate?
    @IBOutlet weak var goldCheckbox: CheckboxButton!
    @IBOutlet weak var officialCheckbox: CheckboxButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        goldCheckbox.on = params?.fshop == "2" ? true : false
        officialCheckbox.on = params?.official == true ? true : false
    }
    @IBAction func toggleGoldCheckbox(_ sender: CheckboxButton) {
        params?.fshop = sender.on ? "2" : "1"
    }
    @IBAction func toggleOfficialCheckbox(_ sender: CheckboxButton) {
        params?.official = sender.on ? true : false
    }
    @IBAction func closeButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func applyBtton(_ sender: UIButton) {
        delegate?.setParamData(param: params!)
        self.navigationController?.popViewController(animated: true)
    }
    
}

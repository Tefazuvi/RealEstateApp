//
//  HomeViewCell.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell{
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var commentsTxt: UITextField!
    @IBOutlet weak var SaveEditButton: UIButton!
    
    var homeId: Int?
    
    var delegate: myTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Add gesture recognizer for each cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @IBAction func saveComments(_ sender: Any) {
        if SaveEditButton.currentTitle == "Edit"
        {
            self.commentsTxt.isEnabled = true
            SaveEditButton.setTitle("Save", for: .normal)
            return
        }else if SaveEditButton.currentTitle == "Save"{
            
            //Safe Unwrap HomeId
            if let homeId = homeId {
                FavoriteModel.updateComments(id: homeId, UserComments: commentsTxt.text)
                SaveEditButton.setTitle("Edit", for: .normal)
                self.commentsTxt.isEnabled = false
            }
            return
        }
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if let homeId = homeId {
            delegate?.myTableDelegate(houseId: homeId)
        }
    }
}

protocol myTableDelegate {
    func myTableDelegate(houseId: Int)
}

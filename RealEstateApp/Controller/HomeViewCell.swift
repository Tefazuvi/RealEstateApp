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
    var delegate: myTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
        //tapGesture.delegate = ViewController()
        
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate()
    }
}

protocol myTableDelegate {
    func myTableDelegate()
}

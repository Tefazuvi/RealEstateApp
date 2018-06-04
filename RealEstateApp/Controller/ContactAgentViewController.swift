//
//  ContactAgentViewController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/3/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class ContactAgentViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    var contact: ContactAgent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRounded(View: containerView)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        if let contact = contact {
            fullNameLbl.text = "\(contact.name) \(contact.lastname)"
            phoneLbl.text = contact.phone
            emailLbl.text = contact.email
            ImageView.image = UIImage(named: contact.profile)
        }
        
        setRounded(View: ImageView)
    }
    
    func setRounded(View: UIView){
        View.layer.cornerRadius = View.frame.height / 6
        View.layer.borderWidth = 4
        View.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        View.clipsToBounds = true
    }
    
    func setRounded(View: UIImageView){
        View.layer.cornerRadius = View.frame.height / 2
        View.layer.borderWidth = 2
        View.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        View.clipsToBounds = true
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

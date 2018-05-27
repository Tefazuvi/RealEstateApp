//
//  ProfileController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/16/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    //static let sharedInstance = ProfileController()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ContentView: UIScrollView!
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRounded(imageView: image)
        ContentView.layer.cornerRadius = 15
        ContentView.layer.borderWidth = 2
        ContentView.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        // Do any additional setup after loading the view.
        
    }
    
    func showUser(user: UserModel){
        //let user = LoginController.sharedInstance.currentUser
        fullName.text = user.name + " " + user.lastname
        phone.text = user.phone
        email.text = user.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //try show user here
        let user = LoginController.sharedInstance.currentUser
        fullName.text = "Nombre: " + user!.name + " " + user!.lastname
        phone.text = "Teléfono: " + user!.phone
        email.text = "Email: " + user!.email

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRounded(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        imageView.clipsToBounds = true
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  ProfileController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/16/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ContentView: UIScrollView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var RememberSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRounded(imageView: image)
        ContentView.layer.cornerRadius = 15
        ContentView.layer.borderWidth = 4
        ContentView.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Loads user information when the view shows
        let user = LoginController.sharedInstance.currentUser
        if user != nil{
            fullName.text = "Nombre: " + user!.name! + " " + user!.lastname!
            phone.text = "Teléfono: " + user!.phone!
            email.text = "Email: " + user!.email
            
            if user!.profile != nil{
                getImage(strbase64: user!.profile!)
            }
        }else{
            let alert = UIAlertController(title: "Debe ingresar con su cuenta de usuario.", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                self.performSegue(withIdentifier: "ShowHouses", sender: self)
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.performSegue(withIdentifier: "ShowLogin", sender: self)
            }))
            
            self.present(alert, animated: true)
        }
        
        if let userSystem = LoginController.sharedInstance.userSystem {
            RememberSwitch.isOn = userSystem.remember
        }else{
            RememberSwitch.isOn = false
        }
        
    }
    
    @IBAction func SwitchToggle(_ sender: Any) {
        if RememberSwitch.isOn {
            LoginController.sharedInstance.saveUser()
        } else {
            LoginController.sharedInstance.forgetUser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImage(strbase64: String){
        let dataDecoded : Data = Data(base64Encoded: strbase64, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        image.image = decodedimage
    }
    
    func setRounded(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 4
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
    
}

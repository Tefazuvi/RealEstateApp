//
//  MainTabBarController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/2/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //create a new button
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "LogInOut"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(self.logInOutPressed(_:)), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationItem.title = "CR PURA VIDA REAL ESTATE"
    }
    
    //This method will call when you press button.
    @objc func logInOutPressed(_ sender: UIBarButtonItem) {
        if(LoginController.sharedInstance.isLogged){
            LoginController.sharedInstance.logOut()
        }
        self.performSegue(withIdentifier: "ShowLogin", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LogIn_Out(){
        //If the user is Logged then LogOut is performed
        if LoginController.sharedInstance.isLogged {
            
        }else{
            //Goes to Login
            
        }
    }
    
}

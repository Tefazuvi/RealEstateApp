//
//  LoginController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/16/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate{
    
    static let sharedInstance = LoginController()
    
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    var activityIndicator = UIActivityIndicatorView()
    var isLogged = false
    var rememberUser = true
    var LogOut = false
    
    @IBOutlet weak var RememberSwitch: UISwitch!
    
    var currentUser:UserModel?
    var userSystem:UserSystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        // Do any additional setup after loading the view.
        UserNameText.delegate = self
        PasswordText.delegate = self
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        //Check if theres login credentials saved and login
        if !LoginController.sharedInstance.LogOut {
           silentLogin()
        }
    }
    
    deinit{
        
        //Stop listening for keyboard hide/show events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardFrame:CGRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame{
            view.frame.origin.y = -keyboardFrame.height + 50
        }else{
            view.frame.origin.y = 0
        }
    }
    
    @IBAction func SwitchToggle(_ sender: Any) {
        if RememberSwitch.isOn {
            rememberUser = true
        } else {
            rememberUser = false
        }
    }
    
    func forgetUser(){
        guard let current = LoginController.sharedInstance.currentUser else { return }
        UserSystem.updateUser(id: current.idUser, rememberValue: false)
    }
    
    func silentLogin(){
        guard let userSaved = UserSystem.getLast() else{ return } //Safe unwrap or early return
        if userSaved.remember {
            UserNameText.isEnabled = false
            PasswordText.isEnabled = false
            UserNameText.text = userSaved.email
            PasswordText.text = userSaved.password
            LoginController.sharedInstance.userSystem = userSaved
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            RESTAPIManager.sharedInstance.getUser(email: userSaved.email, password: userSaved.password, onSuccess: {
                json in
                DispatchQueue.main.async {
                    if let user = String(describing: json).data(using: .utf8){
                        LoginController.sharedInstance.currentUser = try! JSONDecoder().decode(UserModel.self, from: user)
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        LoginController.sharedInstance.isLogged = true
                        self.performSegue(withIdentifier: "ShowHome", sender: self)
                    }
                }
            }, onFailure: { error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.show(alert, sender: nil)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func saveUser(){
        if let NewUser = LoginController.sharedInstance.currentUser {
            LoginController.sharedInstance.userSystem = UserSystem.saveUser(newUser: NewUser)
        }
    }
    
    func authenticate(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        LoginController.sharedInstance.isLogged = true
        self.performSegue(withIdentifier: "ShowHome", sender: self)
        
        UserNameText.text = ""
        PasswordText.text = ""
        
        if rememberUser {
            saveUser()
        }
    }
    
    func logOut(){
        LoginController.sharedInstance.isLogged = false
        LoginController.sharedInstance.currentUser = nil
        LoginController.sharedInstance.userSystem = nil
        LoginController.sharedInstance.LogOut = true
    }
    
    
    @IBAction func Ingresar(_ sender: Any) {
        LoginController.sharedInstance.LogOut = false
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        RESTAPIManager.sharedInstance.getUser(email: UserNameText.text!, password: PasswordText.text!, onSuccess: {
            json in
            DispatchQueue.main.async {
                if let user = String(describing: json).data(using: .utf8){
                    LoginController.sharedInstance.currentUser = try! JSONDecoder().decode(UserModel.self, from: user)
                    self.authenticate()
                }
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    
}

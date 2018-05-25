//
//  LoginController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/16/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
    }
    
    deinit{
        
        //Stop listening for keyboard hide/show events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
     func hideKeyboard(textField: UITextField){
     textField.resignFirstResponder()
     }*/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func authenticate(){
        signSucces()
        if(UserNameText.text == "User" && PasswordText.text == "123")
        {
            signSucces()
        }else{
            //De momento nada
        }
    }
    
    func signSucces(){
        //DispatchQueue.main.async(){
        self.performSegue(withIdentifier: "ShowHome", sender: self)
        //}
    }
    
    
    @IBAction func Ingresar(_ sender: Any) {
        authenticate()
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

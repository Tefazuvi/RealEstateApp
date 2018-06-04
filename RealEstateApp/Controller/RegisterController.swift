//
//  RegisterController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/17/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var activityIndicator = UIActivityIndicatorView()
    var activeTextField: UITextField!
    var picture: UIImage!
    var strBase64: String?
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRounded(imageView: image)
        image.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterController.imageTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        
        name.delegate = self
        lastname.delegate = self
        phone.delegate = self
        email.delegate = self
        confirmEmail.delegate = self
        password.delegate = self
        
        name.layer.borderWidth = 2
        lastname.layer.borderWidth = 2
        phone.layer.borderWidth = 2
        email.layer.borderWidth = 2
        confirmEmail.layer.borderWidth = 2
        password.layer.borderWidth = 2
        
        name.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        lastname.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        phone.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        email.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        confirmEmail.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        password.layer.borderColor = hexStringToUIColor(hex:"#336666").cgColor
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
    }
    
    @objc func imageTapped()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Se ha creado su cuenta, ingrese su usuario y contraseña.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "ShowLogin", sender: self)
        }))
        
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.contentMode = .scaleAspectFill
            image.image = pickedImage
            //picture = pickedImage.resized(withPercentage: 0.5)
            picture = pickedImage
        }
        dismiss(animated: true, completion: nil)
        
        //Use image to convert intro NSData format
        let imageData:NSData = UIImageJPEGRepresentation(picture, 0.25)! as NSData
        strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    deinit{
        
        //Stop listening for keyboard hide/show events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    
    @objc func keyboardWillChange(notification: Notification){
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame{
            
            if  let userInfo = notification.userInfo,
                let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
                let animationCurveRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            {
                let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: UIViewAnimationOptions.RawValue(truncating: animationCurveRaw))
                let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height-30, 0.0)
                
                UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
                    self.scrollView.contentInset = contentInsets
                    self.scrollView.scrollIndicatorInsets = contentInsets
                    
                    var aRect : CGRect = self.view.frame
                    aRect.size.height -= keyboardSize.height
                    if let activeField = self.activeTextField {
                        if (!aRect.contains(activeField.frame.origin)){
                            self.scrollView.scrollRectToVisible(activeField.frame, animated: false)
                        }
                    }
                }, completion: nil)
            }
        } else if notification.name == Notification.Name.UIKeyboardWillHide{
            
            if  let userInfo = notification.userInfo,
                let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
                let animationCurveRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            {
                let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: UIViewAnimationOptions.RawValue(truncating: animationCurveRaw))
                
                UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
                    self.scrollView.contentInset = .zero
                    self.scrollView.scrollIndicatorInsets = .zero
                    self.view.endEditing(true)
                }, completion: nil)
            }
        }
    }
    
    // Assign the newly active text field to your activeTextField variable
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setRounded(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
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
    
    
    @IBAction func Register(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let newUser = UserModel(Id: 0, Name: name.text, LastName: lastname.text, Email: email.text!, Password: password.text!, Phone: phone.text, Type: 1, Profile: strBase64)
        
        RESTAPIManager.sharedInstance.saveUser(user: newUser , onSuccess: {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.showAlert()
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
        
    }
    
}

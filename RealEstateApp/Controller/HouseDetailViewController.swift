//
//  HouseDetailViewController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    var index: Int = 0
    let arrPictures = ["home1","home2","home3","home4","home5","home6"]
    var swipeGesture  = UISwipeGestureRecognizer()
    
    @IBOutlet weak var imageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        ImageView.image = UIImage(named:arrPictures[index])
        imageLabel.text = "\(index+1)/\(arrPictures.count)"
        
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
        
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeEnd(_:)))
            ImageView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            ImageView.isUserInteractionEnabled = true
            ImageView.isMultipleTouchEnabled = true
        }
    }
    
    @objc func swipeEnd( _ sender : UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if(index < arrPictures.count-1)
            {
                index += 1
            }else{
                index = 0
            }
        }else if sender.direction == .right
        {
            if(index > 0)
            {
                index -= 1
            }else{
                index = arrPictures.count - 1
            }
        }
        ImageView.image = UIImage(named:arrPictures[index])
        imageLabel.text = "\(index+1)/\(arrPictures.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            self.tabBarController?.tabBar.isHidden = false
        }
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

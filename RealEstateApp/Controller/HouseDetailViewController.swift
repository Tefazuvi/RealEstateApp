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
    var house: HouseModel?
    var index: Int = 0
    var arrPictures = [String]()
    var swipeGesture  = UISwipeGestureRecognizer()
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var Address1Label: UILabel!
    @IBOutlet weak var Address2Label: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var LandSizeLabel: UILabel!
    @IBOutlet weak var BuildingSizeLabel: UILabel!
    @IBOutlet weak var BathroomsLabel: UILabel!
    @IBOutlet weak var GarageLabel: UILabel!
    @IBOutlet weak var SecurityLabel: UILabel!
    @IBOutlet weak var DetailsLabel: UILabel!
    @IBOutlet weak var BedRoomsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
        
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeEnd(_:)))
            ImageView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            ImageView.isUserInteractionEnabled = true
            ImageView.isMultipleTouchEnabled = true
        }
        
        guard let house = house else {
            print("Error")
            return
        }
        
        setButtonImage()
        arrPictures = house.pictures
        Address1Label.text = house.address1
        Address2Label.text = house.address2
        PriceLabel.text = "₡ " + house.price
        LandSizeLabel.text = String(house.size) + " m2"
        BuildingSizeLabel.text = String(house.buildingSize) + " m2"
        BedRoomsLabel.text = "\(house.bedrooms) Cuartos"
        BathroomsLabel.text = "\(house.bathrooms) Baños"
        GarageLabel.text = String(house.garage) +  " Espacios"
        DetailsLabel.text = house.details
        if house.security {
            SecurityLabel.text = "Sí"
        }else{
            SecurityLabel.text = "No"
        }
        
        // Do any additional setup after loading the view.
        ImageView.image = UIImage(named:arrPictures[index])
        imageLabel.text = "\(index+1)/\(arrPictures.count)"
    }
    
    @objc func swipeEnd( _ sender : UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if(index < (arrPictures.count)-1)
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
                index = (arrPictures.count) - 1
            }
        }
        ImageView.image = UIImage(named:arrPictures[index])
        imageLabel.text = "\(index+1)/\(arrPictures.count)"
    }
    
    @IBAction func FavoriteButton(_ sender: Any) {
        if let house = house{
            house.changeFavorite()
            setButtonImage()
        }
    }
    
    func setButtonImage(){
        guard let house = house else { return }
        if(house.isFavorite)
        {
            favButton.setImage(UIImage(named: "heartIconFilled"), for: UIControlState.normal)
        }else{
            favButton.setImage(UIImage(named: "heartIcon"), for: UIControlState.normal)
        }
    }
    @IBAction func ShowContactAgent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactVC = storyboard.instantiateViewController(withIdentifier: "ContactAgentView") as! ContactAgentViewController
        //detailVC.house = list.houseList[houseId]
        //self.navigationController?.pushViewController(contactVC, animated: true)
        self.addChildViewController(contactVC)
        contactVC.view.frame = self.view.frame
        self.view.addSubview(contactVC.view)
        contactVC.didMove(toParentViewController: self)
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
    
    
    
}

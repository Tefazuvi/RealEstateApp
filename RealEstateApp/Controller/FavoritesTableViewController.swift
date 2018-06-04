//
//  FavoritesTableViewController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 6/3/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, myTableDelegate, UITextFieldDelegate {
    
    @IBOutlet var myTableView: UITableView!
    var list = [FavoriteModel]()
    let homes =  HouseListModel.sharedInstance
    var refresher: UIRefreshControl!
    
    @objc func refresh(){
        if loadFavorites()>0 {
            self.tableView.reloadData()
        }
        self.refresher.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        refresher.attributedTitle = NSAttributedString(string: "Actualizando")
        
        refresher.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        refresh()
        
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(FavoritesTableViewController.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FavoritesTableViewController.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWasShown (notification: NSNotification)
    {
        guard let keyboardFrame:CGRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        myTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
        myTableView.scrollIndicatorInsets = myTableView.contentInset
    }
    
    @objc func keyboardWillBeHidden (notification: NSNotification)
    {
        myTableView.contentInset = UIEdgeInsets.zero
        myTableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    func loadFavorites()->Int{
        if FavoriteModel.countObjects()>0 {
            list = FavoriteModel.getAllFavorites()
        }else{
            let alert = UIAlertController(title: "No tiene favoritos.", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                self.performSegue(withIdentifier: "ShowHouses", sender: self)
            }))
            
            self.present(alert, animated: true)
        }
        return FavoriteModel.countObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Favoritos", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! HomeViewCell
        cell.view.layer.cornerRadius = 10
        cell.delegate = self
        cell.commentsTxt.delegate = self
        
        let houseId = list[indexPath.row].idHouse
        
        let coverImage = homes.houseList[houseId].pictures[0]
        cell.AddressLabel.text = homes.houseList[houseId].address1
        cell.sizeLabel.text = String(homes.houseList[houseId].size) + " m2"
        cell.priceLabel.text = "₡ " + String(homes.houseList[houseId].price)
        cell.ImageView?.image = UIImage(named: coverImage)
        cell.homeId = houseId
        cell.commentsTxt.text = list[indexPath.row].comments
        return cell
    }
    
    func myTableDelegate(houseId: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "HouseDetailViewController") as! HouseDetailViewController
        detailVC.house = homes.houseList[houseId]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

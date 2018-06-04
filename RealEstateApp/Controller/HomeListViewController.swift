//
//  HomeListViewController.swift
//  RealEstateApp
//
//  Created by Stephanie Zuniga on 5/20/18.
//  Copyright © 2018 Stephanie Zuniga. All rights reserved.
//

import UIKit

class HomeListViewController: UITableViewController, myTableDelegate {
    
    @IBOutlet var myTableView: UITableView!
    let list = HouseListModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        if FavoriteModel.countObjects()>0 {
            let favorites = FavoriteModel.getAllFavorites()
            
            for favorite in favorites {
                list.houseList[favorite.idHouse].changeFavorite()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Casas", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.houseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewCell
        cell.view.layer.cornerRadius = 10
        cell.delegate = self
        
        let coverImage = list.houseList[indexPath.row].pictures[0]
        cell.AddressLabel.text = list.houseList[indexPath.row].address1
        cell.sizeLabel.text = String(list.houseList[indexPath.row].size) + " m2"
        cell.priceLabel.text = "₡ " + String(list.houseList[indexPath.row].price)
        cell.ImageView?.image = UIImage(named: coverImage)
        cell.homeId = list.houseList[indexPath.row].id
        return cell
    }
    
    func myTableDelegate(houseId: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "HouseDetailViewController") as! HouseDetailViewController
        detailVC.house = list.houseList[houseId]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//
//  TableViewController.swift
//  SplitVC_Test
//
//  Created by Anas Zaheer on 05/04/17.
//  Copyright © 2017 nfnlabs. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    private var arrayMenuOptions = [["title":"Home", "icon":"iconHome"], ["title":"Service", "icon":"iconService"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientBackground(colorTop: .clear, colorBottom: .white)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMenuOptions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let split = self.splitViewController
        {

            if let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController, indexPath.row == 0{
                
              //  let mode = split.displayMode
              //  if mode == .primaryOverlay {
                  //  split.preferredDisplayMode = .primaryHidden
              //  }
             split.showDetailViewController(VC, sender: nil)
                //self.performSegue(withIdentifier: "home", sender: self)
            }else if let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController{
                split.showDetailViewController(VC, sender: nil)
            }
        }
    }
 
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "setting" {
            let controller = (segue.destination as! UINavigationController).topViewController as! SettingViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }else{
            let controller = (segue.destination as! UINavigationController).topViewController as! HomeViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            
        }
        
    }
    
}

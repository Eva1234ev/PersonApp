//
//  PersonsTableViewCell.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

class PersonsTableViewCell: UITableViewCell {
    
    @IBOutlet private var personView: UIView!
    @IBOutlet private var personImage: UIImageView!
    @IBOutlet private var personFullNameLabel: UILabel!
    @IBOutlet private var personTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personView.layer.cornerRadius = 10
        personView.layer.masksToBounds = true
        
        personImage.layer.cornerRadius =  personImage.frame.height/2
        personImage.layer.masksToBounds = true
    }
    
    func configure(with person: Person?) {
          
          if let person = person {
              personFullNameLabel.text = person.name
              personTimeLabel.convertStrToDate(date: person.time)
              if let url = URL( string:person.image!)
              {
                  personImage.load(url: url, id : person.itemId!)
              }else {
                  personImage.image =  UIImage(named: "profile")
              }
              personView.alpha = 1
          } else {
              
              personView.alpha = 0
          }
      }
    
}

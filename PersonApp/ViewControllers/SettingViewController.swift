//
//  SettingViewController.swift
//  PersonApp
//
//  Created by Eva on 10/14/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateAnimation(imageView: settingImageView)
        settingImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
    }
    
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;

        imageView.layer.add(rotateAnimation, forKey: nil)
    }

   

}

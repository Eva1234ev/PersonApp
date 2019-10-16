//
//  UIImageView.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL , id: String) {
        
        if let image = imageCache.image(forKey: id) {
            self.image = image
        } else {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            self.addSubview(activityIndicator)
            activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY);
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            DispatchQueue.global().async { [weak self] in
                
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            imageCache.add(image, forKey: id)
                            activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
}

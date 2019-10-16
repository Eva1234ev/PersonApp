//
//  ImageCash.swift
//  PersonApp
//
//  Created by Eva on 10/13/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
let imageCache = ImageCache()

class ImageCache: NSCache<AnyObject, AnyObject> {
    func add(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as AnyObject)
    }
    
    func image(forKey key: String) -> UIImage? {
        guard let image = object(forKey: key as AnyObject) as? UIImage else { return nil }
        return image
    }
}

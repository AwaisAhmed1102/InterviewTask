//
//  ImageCache.swift
//  Interview Task
//
//  Created by Apple on 11/27/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import Foundation
import UIKit

class ImageCache{
    
    static var imageCacher = ImageCache()
    let imageCache = NSCache<NSString, UIImage>()
    
    
    private init(){}
    
}

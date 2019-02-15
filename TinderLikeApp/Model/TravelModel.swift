//
//  TravelModel.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/15.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation
import  UIKit

struct TravelModel {
    
    let id: Int
    let title: String
    let image: UIImage
    let published: String
    let access: String
    let budget: String
    let message: String
    
    //MARK: - Initializer
    
    init(id: Int, title: String, imageName: String, published: String, access: String, budget: String, message: String) {
        self.id = id
        self.title = title
        self.image = UIImage(named: imageName)!
        self.published = published
        self.access = access
        self.budget = budget
        self.message = message
    }
}

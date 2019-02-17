//
//  UIViewControllerExtension.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/17.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //この画面のナビゲーションバーを設定する
    public func setupNavigationBarTitle(_ title: String) {
        
        //NavigationControllerのデザイン設定
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = UIFont(name: "HiraKakuProN-W6", size: 14.0)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        
        self.navigationController!.navigationBar.barTintColor = UIColor(code: "#76b6e2")
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        //タイトルを入れる
        self.navigationItem.title = title
    }
}

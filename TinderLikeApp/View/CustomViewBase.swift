//
//  CustomViewBase.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/14.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation
import UIKit

class CustomViewBase: UIView {
    
    //コンテンツ表示用のview
    weak var contentView: UIView!
    
    //このカスタムviewをコードで使用する際の初期化処理
    required override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    //このカスタムviewをInterfaceBuilderで使用する際の初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContentView()
    }
    
    //コンテンツ表示用のview初期化処理
    private func initContentView() {
        
        //追加するcontentviewのクラス名を取得する
        let viewClass: AnyClass = type(of: self)
        
        // 追加するcontentViewに関する設定をする
        contentView = Bundle(for: viewClass)
            .loadNibNamed(String(describing: viewClass), owner: self, options: nil)?.first as? UIView
        contentView.autoresizingMask = autoresizingMask
        contentView.frame = bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        //追加するcontentViewの制約設定をする。上下左右0
        let bindings = ["view": contentView as Any]
        
        let contentViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[view]|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: bindings
        )
        
        let contentViewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[view]|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: bindings
        )
        
        addConstraints(contentViewConstraintH)
        addConstraints(contentViewConstraintV)
        
        initWith()
    }
    
    //MARK: - Function
    func initWith() {
        
    }
}

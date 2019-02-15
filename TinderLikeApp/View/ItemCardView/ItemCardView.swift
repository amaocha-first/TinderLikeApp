//
//  ItemCardView.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/14.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation
import UIKit

protocol ItemCardDelegate: NSObjectProtocol {
    // ドラッグ開始時に実行されるアクション
    func beganDragging()
    // 位置の変化が生じた際に実行されるアクション
    func updatePosition(_ itemCardView: ItemCardView, centerX: CGFloat, centerY: CGFloat)
    // 左側へのスワイプ動作が完了した場合に実行されるアクション
    func swipedLeftPosition()
    // 右側へのスワイプ動作が完了した場合に実行されるアクション
    func swipedRightPosition()
    // 元の位置に戻る動作が完了したに実行されるアクション
    func returnToOriginalPosition()
}

class ItemCardView: UIView {
    
    // この View の初期状態の中心点を決める変数 (意図的に揺らぎを与えてランダムで少しずらす)
    private var initialCenter: CGPoint = CGPoint(
        x: UIScreen.main.bounds.size.width / 2,
        y: UIScreen.main.bounds.size.height / 2
    )
    // この View の初期状態の傾きを決める変数 (意図的に揺らぎを与えてランダムで少しずらす)
    private var initialTransform: CGAffineTransform = .identity
    
    // 初期化される前と後の拡大縮小比
    private let beforeInitializeScale: CGFloat = 1.00
    private let afterInitializeScale: CGFloat = 1.00
    
    //拡大画像を見るボタン
    @IBOutlet weak private var largeImageButton: UIButton!
    
    // MARK: - Initializer
    func initWith() {
        setupItemCardView()
        setupSlopeAndIntercept()
        setupInitialPositionWithAnimation()
    }
    
    private func setupItemCardView() {
        // この View の基本的な設定
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        self.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 360))
        
        //このViewの装飾に関する設定
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor(hex: "#dddddd") as! CGColor
        self.layer.borderWidth = 0.75
        self.layer.cornerRadius = 0.00
        self.layer.shadowRadius = 3.00
        self.layer.shadowOpacity = 0.50
        self.layer.shadowOffset = CGSize(width: 0.75, height: 1.75)
        self.layer.shadowColor = UIColor(hex: "#dddddd") as! CGColor
        
        //「拡大画像を見る」ボタンに対する初期設定を行う
        largeImageButton.addTarget(self, action: #selector(self.largeImageButtonTapped), for: .touchUpInside)
    }
    
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}

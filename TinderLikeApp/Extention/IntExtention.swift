//
//  IntExtention.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/14.
//  Copyright © 2019 amaocha. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    // 決まった範囲内(負数値を含む)での乱数値を作る
    // 参考:https://qiita.com/lovee/items/67db977a1afc80b3148d
    static func createRandom(range: Range<Int>) -> Int {
        let rangeLength = range.upperBound - range.lowerBound
        let random = arc4random_uniform(UInt32(rangeLength))
        return Int(random) + range.lowerBound
    }
}

// 例. -300 から 300 までの中からランダムな値を 1 つ取得する
let randomInt = Int.createRandom(range: Range(-300...300))

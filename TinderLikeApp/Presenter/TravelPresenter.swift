//
//  TravelPresenter.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/15.
//  Copyright © 2019 amaocha. All rights reserved.
//
// 補足:
// TravelModel では表示するためのデータ構造を定義する
//
// 実行される処理の流れ:
// 1. ViewController 側で getTravelModels() を実行する
// 2. bindTravelModels(_ travelModels: [TravelModel]) が実行される
// 3. 受け取った [TravelModel] を反映する処理をする

import Foundation
import UIKit

protocol TravelPresenterProtocol: class {
    func bindTravelModels(_ travelModels: [TravelModel])
}

class TravelPresenter {
    
    var presenter: TravelPresenterProtocol!
    
    //MARK: - Initializer
    
    init(presenter: TravelPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - Funcitons
    
    //データの一覧を取得する
    func getTravelModels() {
        let travelModels = generateTravelModels()
        self.presenter.bindTravelModels(travelModels)
    }
    
    //MARK: - Private Functions
    
    //データの一覧を作成する
    private func generateTravelModels() -> [TravelModel] {
        return [
            TravelModel(
                id: 1,
                titile, "青森の自然風景",
                imageName: "aomori",
                published: "2018.08.20",
                access: "新幹線で約３時間",
                budget: "¥ 50,000程度",
                message: "自然に溢れたスポット満載"
            ),
            //必要な数のカードの表示数分データを作成する
        ]
    }
}

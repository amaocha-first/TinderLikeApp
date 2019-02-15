//
//  ViewController.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/14.
//  Copyright © 2019 amaocha. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //カード表示用のViewを格納するための配列
    private var itemCardViewList: [ItemCardView] = []
    
    //TravelPresenterに設定したプロトコルを適用するための変数
    private var presenter: TravelPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupTravelPresenter()
    }
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private Function
    
    // カードの内容をボタン押下時に実行されるアクションに関する設定を行う
    @objc private func refreshButtonTapped() {
        presenter.getTravelModels()
    }
    
    private func setupNavigationController() {
        setupNavigationBarTitle("気になる旅行")
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = UIFont(name: "HiraKakuProN-W3", size: 13.0)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        
        let rightButton = UIBarButtonItem(
            title: "再追加",
            style: .done,
            target: self,
            action: #selector(self.refreshButtonTapped)
        )
        rightButton.setTitleTextAttributes(attributes, for: .normal)
        rightButton.setTitleTextAttributes(attributes, for: .highlighted)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    //Presenterとの接続に関する設定を行う
    private func setupTravelPresenter() {
        presenter = TravelPresenter(presenter: self)
        presenter.getTravelModels()
    }
    
    //UIAlertViewControllerのポップアップ共通化を行う
    private func shouwAlertControllerWith(title: String, message: String) {
        
        let singleAlert = UIAlertController(
            title: title, message: message, preferredStyle: .alert
        )
        
        singleAlert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        
        )
        self.present(singleAlert, animated: true, completion: nil)
    }
    
    //画面上にカード表示用のviewを追加&付随した処理を行う
    private func addItemCardViews(_ travelModels: [TravelModel]) {
        
        for index in 0..<travelModels.count {
            
            //ItemCardViewのインスタンスを作成してプロトコル宣言やタッチイベント等の初期設定を行う
            let itemCardView = ItemCardView()
            itemCardView.delegate = self
            itemCardView.setModelData(travelModels[index])
            itemCardView.largeImageButtonTappedHandler = {
                
                //画像の拡大縮小が可能な画面へ遷移する
                let storyboard = UIStoryboard(name: "Photo", bundle: nil)
                let controller = storyboard.instantiateInitialViewController() as! PhotoViewController
                controller.setTargetTravelModel(travelModels[index])
                controller.modalPresentationStyle = .overFullScreen
                controller.modalTransitionStyle   = .crossDissolve
                self.present(controller, animated: true, completion: nil)
            }
            
            itemCardView.isUserInteractionEnabled = false
            
            //カード表示用のviewを格納するための配列に追加する
            itemCardViewList.append(itemCardView)
            
            //現在表示されているカードの背面へ新たに作成したカードを追加する
            view.addSubview(itemCardView)
            view.sendSubview(toBack: itemCardView)
        }
        
        //MEMO: 配列に格納されているviewのうち、先頭にあるviewのみを操作可能にする
        enableUserInteractionToFirstItemCardView()
        
        //画面上にあるカードの山の拡大縮小比を調節する
        changeScaleToItemCardViews(skipSelectedView: false)
    }
    
    // 画面上にあるカードの山のうち、一番上にある View のみを操作できるようにする
    private func enableUserInteractionToFirstItemCardView() {
        if !itemCardViewList.isEmpty {
            if let firstItemCardView = itemCardViewList.first {
                firstItemCardView.isUserInteractionEnabled = true
            }
        }
    }
    
    //現在配列に格納されている(画面上にカードの山として表示されている)Viewの拡大縮小を調節する
    private func changeScaleToItemCardViews(skipSelectedView: Bool = false) {
        
        //アニメーション関連の定数値
        let duration: TimeInterval = 0.26
        let reduceRatio: CGFloat = 0.03
        
        var itemCount: CGFloat = 0
        for (itemIndex, itemCardView) in itemCardViewList.enumerated() {
            
            //現在操作中のviewの縮小比を変更しない場合は、以降の処理をスキップする
            if skipSelectedView && itemIndex == 0 { continue }
            
            //後ろに配置されているviewほど小さく見えるように縮小比を調節する
            let itemScale: CGFloat = 1 - reduceRatio * itemCount
            UIView.animate(withDuration: duration, animations: {
                itemCardView.transform = CGAffineTransform(scaleX: itemScale, y: itemScale)
            })
            itemCount += 1
        }
    }
}

//MARK: - TravelPresenterProtocol
extension MainViewController: TravelPresenterProtocol {
    
    //Presenterでデータ取得処理を実行した際に行われる処理
    func  bindTravelModels(_ travelModels: [TravelModel]) {
    
        //表示用のViewを格納するための配列[itemCardViewList]が空なら追加する
        if itemCardViewList.count > 0 {
            shouwAlertControllerWith(title: "まだカードが残っています", message: "両面からカードがなくなったら。、\n 再度追加をお願いします。\n※サンプルデータ計8件")
            return
        } else {
            addItemCardViews(travelModels)
        }
   
    }
}

extension MainViewController {
    
    //この画面のナビゲーションバーに設定するメソッド
    public func setupNavigationBarTitle(_ title: String) {
        
        //NavigationControllerのデザイン調整を行う
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = UIFont(name: "HiraKakuProN-W6", size: 14.0)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        
        self.navigationController!.navigationBar.tintColor = UIColor(hex: "#333333")
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        //タイトルを入れる
        self.navigationItem.title = title
    }
    
    //戻るボタンの「戻る」テキストを削除した状態にするメソッド
    public func removeBackButtonText() {
        let backBUttonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backBUttonItem
    }
}


//
//  PhotoViewController.swift
//  TinderLikeApp
//
//  Created by coco j on 2019/02/15.
//  Copyright © 2019 amaocha. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private var targetTravelModel: TravelModel!
    
    @IBOutlet weak private var photoScrollView: UIScrollView!
    @IBOutlet weak private var photoImageView: UIImageView!
    
    
    //ヘッダー位置に配置しているタイトルと閉じるボタンのviewに配置するもの
    @IBOutlet weak var photoHeaderView: UIView!
    @IBOutlet weak var photoCloseButton: UIButton!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    //UIScrollViewの中にあるUIImageViewの上下左右の制約
    @IBOutlet weak var photoImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageViewLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPhotoScrollView()
        setupPhotoHeaderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Function
    
    func setTargetTravelModel(_ travelModel: TravelModel) {
        targetTravelModel = travelModel
    }
    
    // MARK: - Private Function
    
    // 閉じるボタン押下時に実行されるアクションに関する設定を行う
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupPhotoScrollView() {
        photoScrollView.delegate = self
        photoImageView.image = targetTravelModel.image
        initializePhotoImageViewScale(self.view.bounds.size)
    }
    
    private func setupPhotoHeaderView() {
        photoTitleLabel.text = targetTravelModel.title
        photoCloseButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
    }
    
    // 画面に初回表示をした際の写真の拡大縮小比を設定する
    private func initializePhotoImageViewScale(_ size: CGSize) {
        
        // self.viewのサイズを元にUIImageViewに表示する画像の縦横サイズの比を取り、小さい方を適用する
        let widthScale  = size.width / photoImageView.bounds.width
        let heightScale = size.height / photoImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        // 現在時点と最小のUIScrollViewの拡大縮小比を設定する
        photoScrollView.minimumZoomScale = minScale
        photoScrollView.zoomScale = minScale
    }
    
    // UIScrollViewの中で拡大・縮小の動きに合わせて中のUIImageViewの大きさを変更する
    private func updatePhotoImageViewScale(_ size: CGSize) {
        
        // X軸方向のAutoLayoutの制約を加算する
        let xOffset = max(0, (size.width - photoImageView.frame.width) / 2)
        photoImageViewRightConstraint.constant = xOffset
        photoImageViewLeftConstraint.constant  = xOffset
        
        // Y軸方向のAutoLayoutの制約を加算する
        let yOffset = max(0, (size.height - photoImageView.frame.height) / 2)
        photoImageViewTopConstraint.constant    = yOffset
        photoImageViewBottomConstraint.constant = yOffset
        
        // Debug.
        //print("xOffset:", xOffset)
        //print("yOffset:", yOffset)
        
        self.view.layoutIfNeeded()
    }
    
    // 拡大縮小比を元に拡大されているかを判定してヘッダー用のViewの表示・非表示を切り替える
    private func updatePhotoHeaderViewVisibility() {
        
        // Debug.
        //print("最小の拡大縮小比:", photoScrollView.minimumZoomScale)
        //print("現在時点の拡大縮小比:", photoScrollView.zoomScale)
        
        let expandedPhoto = (photoScrollView.zoomScale > photoScrollView.minimumZoomScale)
        photoHeaderView.isHidden = expandedPhoto
    }
}

// MARK: - UIScrollViewDelegate

extension PhotoViewController: UIScrollViewDelegate {
    
    //（重要）UIScrollViewのデリゲートメソッドの一覧：
    // 参考にした記事：よく使うデリゲートのテンプレート：
    // https://qiita.com/hoshi005/items/92771d82857e08460e5c
    
    // ズーム中に実行されてズームの値に対応する要素を返すメソッド
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    // ズームしたら呼び出されるメソッド ※UIScrollView内のUIImageViewの制約を更新する為に使用する
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updatePhotoImageViewScale(self.view.bounds.size)
        updatePhotoHeaderViewVisibility()
    }
}

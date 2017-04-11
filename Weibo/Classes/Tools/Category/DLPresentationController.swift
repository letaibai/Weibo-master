//
//  DLPresentationController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/11.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit

class DLPresentationController: UIPresentationController {
    // MARK: 对外提供属性
    var presentedFrame : CGRect = CGRect.zero
    
    // MARK: 懒加载属性
    fileprivate lazy var coverView : UIView = UIView()
    
    // MARK: 系统回调函数
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        // 1.设置弹出view的尺寸
        presentedView?.frame = presentedFrame
        
        // 添加蒙版
        setupCoverView()
    }
}
// MARK: 设置UI界面相关
extension DLPresentationController {
    fileprivate func setupCoverView() {
        // 1. 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        
        // 2. 设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = (containerView?.bounds)!
        
        // 3. 添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(DLPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}
// MARK: 事件监听
extension DLPresentationController {
    @objc fileprivate func coverViewClick(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

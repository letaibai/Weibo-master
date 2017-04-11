//
//  DLVistorView.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit

class DLVistorView: UIView {
    // MARK: 提供快速通过xib创建的类方法
    class func visitorView() -> DLVistorView {
        return Bundle.main.loadNibNamed("DLVistorView", owner: nil, options: nil)?.first as! DLVistorView
    }
    
    
    
    // MARK: 控件的属性
    //图标
    @IBOutlet weak var iconView: UIImageView!
    //转盘
    @IBOutlet weak var rotateView: UIImageView!
    //文本
    @IBOutlet weak var discLabel: UILabel!
    // 注册
    @IBOutlet weak var register: UIButton!
    // 登录
    @IBOutlet weak var login: UIButton!
    
    func setupVisitorViewInfo(_ iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        discLabel.text = title
        rotateView.isHidden = true
    }
    func addRotationAnim() {
        // 1. 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2. 设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        
        // 3. 将动画添加到layer中
        rotateView.layer.add(rotationAnim, forKey: nil)
    }
    
}

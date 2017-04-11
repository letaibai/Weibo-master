//
//  DLWelcomeViewController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit
import SDWebImage

class DLWelcomeViewController: UIViewController {
    // MARK: 拖线的属性
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0. 设置头像
        let profileUrlString = DLUserAccountViewModel.sharedInstance.account?.avatar_large
        
        let url = URL(string: profileUrlString ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 1. 改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 200
        
        // 2. 执行动画
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { 
            self.view.layoutIfNeeded()
        }) { (_) in
            // 3. 将创建根控制器改成从Main加载
            UIApplication.shared.keyWindow?.rootViewController = DLMainTableViewController()
        }
    }

}


//
//  DLMainTableViewController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/3.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit


class DLMainTableViewController: UITableViewController {
    
    // MARK: 懒加载属性
    lazy var visitorView : DLVistorView = DLVistorView.visitorView()
    
    //是否登录
    var isLogin : Bool = DLUserAccountViewModel.sharedInstance.isLogin
    
    // MARK: 系统回调函数
    override func loadView() {
        // 判断加载哪一个view
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
    }
}
// MARK: 设置UI界面
extension DLMainTableViewController {
    // 设置访客视图
    fileprivate func setupVisitorView() {
        view = visitorView
        // 监听访客视图中'注册'和'登录'按钮的点击
        visitorView.register.addTarget(self, action: #selector(DLMainTableViewController.registerBtnClick), for: .touchUpInside)
        visitorView.login.addTarget(self, action: #selector(DLMainTableViewController.loginBtnClick), for: .touchUpInside)
    }
    fileprivate func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(DLMainTableViewController.registerBtnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(DLMainTableViewController.loginBtnClick))
        
    }
}

// MARK:  事件监听
extension DLMainTableViewController {
    @objc fileprivate func registerBtnClick() {
        print("registerBtnClick")
        
    }
    @objc fileprivate func loginBtnClick() {
        // 1. 创建授权控制器
        let oauthVc = DLOAuthViewController()
        
        // 2. 包装导航栏控制器
        let oauthNav = UINavigationController(rootViewController: oauthVc)
        
        // 3. 弹出控制器
        present(oauthNav, animated: true, completion: nil)
    }
}

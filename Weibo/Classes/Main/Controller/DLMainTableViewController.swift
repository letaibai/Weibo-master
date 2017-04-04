
//
//  DLMainTableViewController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/3.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit


class DLMainTableViewController: UITableViewController {
    //是否登录
    var isLoaded  = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func loadView() {
        isLoaded ? super.loadView() : setupVistor()
    }
    /// 初始化访客视图
    func setupVistor(){
        let v = UIView()
        v.backgroundColor = UIColor.green
        view = v
    }
}

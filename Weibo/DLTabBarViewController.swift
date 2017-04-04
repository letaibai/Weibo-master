//
//  DLTabBarViewController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/1.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit

class DLTabBarViewController: UITabBarController {
    lazy var composeBtn = UIButton.init(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        ///添加子控制器
        setupVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCompseBtn()
    }
}
// MARK: 初始化UI
extension DLTabBarViewController{
    ///添加子控制器
    func setupVC() {
        addChildVC(childVC: DLHomeTableViewController(), title: "主页", image: UIImage.init(named: "tabbar_home"), selectedImage: UIImage.init(named: "tabbar_home_selected"))
        addChildVC(childVC: DLMessageTableViewController(), title: "消息", image: UIImage.init(named: "tabbar_message_center"), selectedImage: UIImage.init(named: "tabbar_message_center_selected"))
        addChildVC(childVC: UIViewController(), title: "", image: UIImage.init(named: ""), selectedImage: UIImage.init(named: ""))
        addChildVC(childVC: DLDiscoverTableViewController(), title: "发现", image: UIImage.init(named: "tabbar_discover"), selectedImage: UIImage.init(named: "tabbar_discover_selected"))
        addChildVC(childVC: DLProfileTableViewController(), title: "我", image: UIImage.init(named: "tabbar_profile"), selectedImage: UIImage.init(named: "tabbar_profile_selected"))
    }
    
    func addChildVC(childVC : UIViewController ,title : String ,image : UIImage? ,selectedImage : UIImage?){
        childVC.tabBarItem = UITabBarItem.init(title: title, image: image, selectedImage:selectedImage)
        let nav = UINavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }
    func setupCompseBtn(){
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint.init(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        composeBtn.addTarget(self, action: #selector(DLTabBarViewController.composeBtnClcik), for: .touchUpInside)
        
    }
    func composeBtnClcik(){
        print("----")
    }
    
}

//
//  DLButton-Extension.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/1.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init (imageName : String, bgImageName : String) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    convenience init(bgColor : UIColor , fontSize : CGFloat , title : String) {
        self.init()
        
        setTitle(title, for: UIControlState())
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
}

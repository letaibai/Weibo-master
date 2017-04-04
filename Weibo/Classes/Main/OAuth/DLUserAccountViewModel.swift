//
//  DLUserAccountViewModel.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit

class DLUserAccountViewModel: NSObject {
    // MARK: 将类设计成单例
    static let sharedInstance : DLUserAccountViewModel = DLUserAccountViewModel()
    
    // MARK: 定义属性
    var account : DLUserAccount?
    
    // MARK: 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    // 判断是否登录
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else {
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    // MARK: 重写init()函数
    override init() {
        super.init()
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? DLUserAccount
    }
}

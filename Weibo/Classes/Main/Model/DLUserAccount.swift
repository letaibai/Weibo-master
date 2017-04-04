//
//  DLUserAccount.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit


class DLUserAccount: NSObject ,NSCoding{
    // MARK:- 属性
    /// 授权AccessToken
    var accsess_token : String?
    /// 过期时间 --> 秒
    var expires_in :TimeInterval = 0.0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户ID
    var uid : String?
    /// 过期日期
    var expires_date : Date?
    /// 昵称
    var screen_name : String?
    /// 用户的头像地址
    var avatar_large : String?
    
    // MARK: 自定义构造函数
    init(dict : [String : AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    // MARK: 解档&归档
    /// 解档的方法
    required init?(coder aDecoder: NSCoder) {
        accsess_token = aDecoder.decodeObject(forKey: "accsess_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
    /// 归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accsess_token, forKey: "accsess_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    
}

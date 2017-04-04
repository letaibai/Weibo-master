//
//  DLNetworkTools.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import AFNetworking

// 定义枚举类型
enum RequsetType : String {
    case GET = "GET"
    case POST = "POST"
}

class DLNetworkTools: AFHTTPSessionManager {
    // 单例对象
    static let sharedInstance : DLNetworkTools = {
        let tools = DLNetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}
// MARK: 封装请求方法
extension DLNetworkTools {
    func request(_ methodType : RequsetType, urlString : String,parameters : [String : AnyObject], finished : @escaping (_ result : AnyObject?,_ error : NSError?) -> ()){
        // 定义成功的回调闭包
        let successCallBack = {(task : URLSessionDataTask, result : Any?) -> Void in
            finished (result as AnyObject?, nil)}
        
        // 定义失败的回调闭包
        let failureCallBack = {(task : URLSessionDataTask?, error : Error) -> Void in finished(nil, error as NSError?)}
        
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}
// MARK: 请求AccessToken
extension DLNetworkTools {
    func loadAccessToken(_ code : String, finished : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()){
        // 获取请求的urlstring
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code","redirect_uri" : redirect_url, "code" : code]
        
        // 发送网络请求
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String : AnyObject], error)
        }
    }
}



// MARK: 请求用户的信息
extension DLNetworkTools {
    func loadUserInfo(_ access_token : String, uid : String, finished :@escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // |获取请求的参数
        let parameters = ["access_token" : access_token, uid : uid]
        
        // 发送网络请求
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String : AnyObject] , error)
        }
    }
}
// MARK: 请求首页数据
extension DLNetworkTools {
    func loadStatuses(_ since_id : Int, max_id : Int, finished :@escaping (_ result : [[String : AnyObject]]?, _ error : NSError?) -> ()) {
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        // 获取请求的参数
        let accessToken = (DLUserAccountViewModel.sharedInstance.account?.accsess_token)!
        let parameters = ["access_token" : accessToken, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        
        // 发送网络请求
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            // 将数组数据回调给外界控制器
            finished(resultDict["statuses"] as? [[String : AnyObject]], error)
        }
    }
}
// MARK: 发送微博
extension DLNetworkTools {
    func sendStatus(_ statusText : String, isSuccess : @escaping (_ isSuccess : Bool) -> ()){
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 获取请求的参数
        let parameters = ["accsess_token" : (DLUserAccountViewModel.sharedInstance.account?.accsess_token)!,"status" : statusText]
        
        // 发送网络请求
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            if result != nil {
                isSuccess(true)
            } else {
                isSuccess(false)
            }
        }
    }
}
// MARK: 发送微博并且携带照片
extension DLNetworkTools {
    func sendStatus(_statusText : String, image : UIImage, isSuccess : @escaping (_ isSuccess : Bool) -> ()){
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        
        // 获取请求的参数
        let parameters = ["access_token" : (DLUserAccountViewModel.sharedInstance.account?.accsess_token)!,"status" : _statusText]
        
        // 发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (fromData) in
            if let imageData = UIImageJPEGRepresentation(image, 0.5){
                fromData.appendPart(withFileData: imageData, name: "pic", fileName: "123.png", mimeType: "image/png")
            }
        }, progress: nil, success: { (_, _) in
            isSuccess(true)
        }) { (_, error) in
            print(error)
        }
    }
}






















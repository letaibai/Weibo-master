//
//  DLOAuthViewController.swift
//  Weibo
//
//  Created by 李卫 on 2017/4/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

import UIKit
import SVProgressHUD


class DLOAuthViewController: UIViewController {
    // MARK: 控件的属性
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.设置导航栏内容
        setupNavigationBar()
        
        // 2.加载网页QQ
        loadPage()
    }
}
// MARK: 设置UI相关
extension DLOAuthViewController {
    fileprivate func setupNavigationBar(){
        //1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(DLOAuthViewController.closeItemClick))
        //2.设置右侧的item
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(DLOAuthViewController.fillItemClick))
        //3.设置标题
        title = "登录页面"
    }
    fileprivate func loadPage(){
        // 获取登录页面的url
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_url=\(redirect_url)"
        // 创建对应的nsurl
        guard let url = URL.init(string: urlString) else {
            return
        }
        // 创建URLRequest
        let request = URLRequest.init(url: url)
        // 加载request对象
        webView.loadRequest(request)
    }
}
// MARK: 事件监听函数
extension DLOAuthViewController {
    @objc fileprivate func closeItemClick(){
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func fillItemClick(){
        // js代码
        let jsCode = "document.getElementById('userId').value='309324721@qq.com';document.getElementById('passwd').value='Zhuifeng~~1990';"
        //执行
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}
extension DLOAuthViewController : UIWebViewDelegate {
    // webview开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    // webview网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    // webview加载网页失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    // webview开始加载网页
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 获取加载网页的NSURL
        guard let url = request.url else {
            return true
        }
        
        // 获url中的字符串
        let urlString = url.absoluteString
        
        // 判断该字符串中是否包含code
        guard urlString.contains("code=") else {
            return true
        }
        
        // 将code截取出来
        let code = urlString.components(separatedBy: "code=").last!
        
        //请求accessToken
        loadAccessToken(code)
        
        return false
    }
}
extension DLOAuthViewController {
    fileprivate func loadAccessToken(_ code : String) {
        
    }
}


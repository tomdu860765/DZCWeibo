//
//  DZCWebView.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class DZCWebView: UIViewController {

    let urlstr = "https://open.weibo.cn/oauth2/authorize?client_id=\(userid)&redirect_uri=\(useruri)&display=mobile"
   
    
    private lazy var webview=WKWebView()
    
    
    override func loadView() {
        super.loadView()
        self.view=webview
        self.view.backgroundColor=UIColor.orange
        navigationItem.leftBarButtonItem=UIBarButtonItem.init(title: "返回",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(backhomevc))
        webview.scrollView.isScrollEnabled=false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webview.navigationDelegate=self
        
        
        guard let url = URL(string: urlstr) else
        {
            return
        }
        
        let request = URLRequest(url:url)
        
        
        
        webview.load(request)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    @objc private  func backhomevc(){
        
        dismiss(animated: true, completion: nil)
        
        SVProgressHUD.show()
    }
    
    
    
}

extension DZCWebView:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        
        SVProgressHUD.show(withStatus: "玩命加载中")
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        SVProgressHUD.dismiss()
        
    }
    
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if  navigationAction.request.url?.absoluteString.hasPrefix(useruri) == false {
            print(navigationAction.request.url as Any)
            decisionHandler(.allow)
        }else
        {
            
            guard   let codestring =  navigationAction.request.url?.query?.suffix(from:"code=".endIndex)
                else {
                    return
            }

            DZCNetWorkManager.DefaultNetWork.usersignin(code: String(codestring)) { (issuccess:Bool) in
                
                if issuccess==true{
                   
                    SVProgressHUD.showInfo(withStatus:"网络加载成功")
                    
                    self.backhomevc()
                    //通知basevc完成加载数据
                    NotificationCenter.default.post(
                        name:NSNotification.Name(rawValue: UserSigninNotification),
                         object: nil,
                          userInfo: nil)
                }else
                {
                    SVProgressHUD.showInfo(withStatus: "网络加载失败")
                }
                
            }

            decisionHandler(.cancel)
            

        } 
        
    }
}







//
//  DZCWebViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import WebKit
class DZCWebViewController: DZCBaseViewController {

    lazy var webview = WKWebView(frame: CGRect(x: 0, y: mynaviBar.bounds.height,
                                               width: screenbounds.width,
                                               height: screenbounds.height))
    
    var urlstring : String?{
        
        
        didSet{
            
            guard let urlstring = urlstring,
                let url = URL.init(string: urlstring) else{
                
                return
            }
            
            webview.load(URLRequest.init(url: url))
            
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(webview, belowSubview: mynaviBar)
       
        navbar.leftBarButtonItem = UIBarButtonItem(title: "返回", action: #selector(getbackhome),
                                                   target: self, normalcolor: UIColor.black,
                                                   highlightedcolor: UIColor.black)
        self.navibtn.setTitle("网页", for: .normal)
       navbar.titleView=self.navibtn
    }
    @objc func getbackhome(){
        
       navigationController?.popToRootViewController(animated: true)
        
        
    }

    
}

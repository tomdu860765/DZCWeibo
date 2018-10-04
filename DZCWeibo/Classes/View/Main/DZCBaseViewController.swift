//
//  DZCBaseViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import AFNetworking
import YYModel
class DZCBaseViewController: UIViewController {


    
    var refresh :UIRefreshControl?
    //标记刷新状态
    var isrefresh = false
    //标记访客状态
    var isvisitor = false
    //定义一个可变字典属性
    var visitordict : [String:String]?
    
    lazy var mynaviBar:UINavigationBar={
        let bar=UINavigationBar()
        bar.frame = CGRect(x: 0, y: 31, width: UIScreen.main.bounds.width, height: 64)
        
        return bar
    }()
    
    lazy var navbar=UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
       
        view.addSubview(mynaviBar)
        mynaviBar.items=[navbar]
        
        
    }
    
    override var title: String?{
        
        didSet {
            navbar.title=title
        }
    }
    
}


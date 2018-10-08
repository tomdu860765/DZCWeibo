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
    //判断设备高度
    let deviceH = UIScreen.main.bounds.size.height
    
    lazy var navbar=UINavigationItem()

    //定义计时器
    var basevctableview:UITableView?
   //定义tableview
    var ispullup = false
    //标记上下拉状态
    var refresh :UIRefreshControl?
    //标记刷新状态
    var isrefresh = false
    //标记访客状态
   // var isvisitor = false
    //定义一个可变字典属性
    var visitordict : [String:String]?
    lazy var statusBar:UIView={
        let view=UIView()
        if deviceH < 812{
            view.frame=CGRect.zero
        }else
        {
         view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)}
        view.backgroundColor=UIColor.white
        return view
    }()
    
    lazy var mynaviBar:UINavigationBar={
        let bar=UINavigationBar()
        if deviceH < 812{
           bar.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 44)
        }
        bar.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: 44)
        bar.backgroundColor=UIColor.white
        return bar
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(signinsuccess),
                                               name:NSNotification.Name(rawValue: UserSigninNotification) , object: nil)
       
        
        if (DZCNetWorkManager.DefaultNetWork.account.access_token) != nil
        {
              self.setupTableview()

        }else{
               self.setupVisitorView()
           
        }
  
        
        view.addSubview(statusBar)
        view.addSubview(mynaviBar)
        mynaviBar.items=[navbar]
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc   private func signinsuccess(){
        self.view=nil
        DispatchQueue.main.async {
            self.basevctableview?.reloadData()
        }
       NotificationCenter.default.removeObserver(self)
    }
    
    
    override var title: String?{
        
        didSet {
            navbar.title=title
        }
    }
    private func setupVisitorView(){
        let visitorview = DZCVistorView()
        
        visitorview.visitordictionary=self.visitordict
        
        view.insertSubview(visitorview, belowSubview: mynaviBar)
       
    }
  private  func setupTableview(){
        basevctableview=UITableView(frame: UIScreen.main.bounds, style:.plain)
        basevctableview?.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        view.insertSubview(basevctableview!, belowSubview: mynaviBar)
        basevctableview?.showsVerticalScrollIndicator=false
        basevctableview?.contentInsetAdjustmentBehavior = .never
        basevctableview?.contentInset=UIEdgeInsets.init(top:mynaviBar.bounds.size.height ,
                                                        left: 0,
                                                        bottom:tabBarController?.tabBar.bounds.size.height ?? 0,
                                                        right: 0)
        
        
        refresh=UIRefreshControl()
        basevctableview?.addSubview(refresh!)
        self.basevctableview?.reloadData()
    
    }}


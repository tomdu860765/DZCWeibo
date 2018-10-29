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
import SDWebImage
class DZCBaseViewController: UIViewController {
    //判断设备高度
    let deviceH = screenbounds.height
    
    lazy var navbar=UINavigationItem()
    
    //定义计时器
    var basevctableview:UITableView?
    //定义tableview
    var ispullup = false
    //标记上下拉状态
    var refresh :UIRefreshControl?
    //标记刷新状态
    var isrefresh = false
    
    //定义一个可变字典属性
    var visitordict : [String:String]?
    
    lazy var statusBar:UIView={
        var view=UIView()
        if deviceH < 812{
            view.frame=CGRect(x: 0, y: 0, width: screenbounds.size.width, height: 20)
        }else
        {
            view.frame=CGRect(x: 0, y: 0, width: screenbounds.size.width, height: 44)}
        view.backgroundColor=UIColor.white
        return view
    }()
    
    lazy var mynaviBar:UINavigationBar={
        let bar=UINavigationBar()
        if deviceH < 812{
            bar.frame = CGRect(x: 0, y: 20, width: screenbounds.size.width, height: 44)
        }else{
        bar.frame = CGRect(x: 0, y: 44, width: screenbounds.size.width, height: 44)
            }
        bar.backgroundColor=UIColor.white
      
        return bar
    }()
    
    lazy var navibtn:UIButton={
        let btn=UIButton()
        btn.setTitle(DZCAccountModel.init().screen_name, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加观察者响应,并执行方法
        NotificationCenter.default.addObserver(self, selector: #selector(signinsuccess),
                                               name:NSNotification.Name(rawValue: UserSigninNotification) , object: nil)
         basevctableview?.contentInsetAdjustmentBehavior  = .automatic
     
        if (DZCNetWorkManager.DefaultNetWork.account.access_token) != nil
        {
            self.setupTableview()
            navbar.titleView=self.navibtn
            
        }else{
            self.setupVisitorView()
        }
        edgesForExtendedLayout = UIRectEdge.all
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
    //设置访客视图
 private  func setupVisitorView(){
        let visitorview = DZCVistorView()
        
        visitorview.visitordictionary=self.visitordict
        
        view.insertSubview(visitorview, belowSubview: mynaviBar)
        
    }
    //设置tableview
    private  func setupTableview(){
       let frame=CGRect(x: 0, y: 88, width: screenbounds.width, height: screenbounds.height-88)
        basevctableview=UITableView(frame:frame, style:.plain)
        
        let  xib=UINib.init(nibName:"DZCWeiboTableViewCell", bundle: nil)
        let repostxib=UINib.init(nibName: "DZCWeiboRepostTableViewCell", bundle: nil)
        basevctableview?.register(xib, forCellReuseIdentifier: "cellid")
        basevctableview?.register(repostxib, forCellReuseIdentifier: "repostid")
        
    
        view.insertSubview(basevctableview!, belowSubview: mynaviBar)
        basevctableview?.showsVerticalScrollIndicator=false
       
//      basevctableview?.contentInset=UIEdgeInsets(top:mynaviBar.bounds.height+statusBar.bounds.height,
//                                                left: 0, bottom:tabBarController?.tabBar.bounds.height ?? 49
//      , right: 0)
        
        basevctableview?.separatorStyle = .none
        basevctableview?.estimatedRowHeight=450
        
        refresh=UIRefreshControl()
        basevctableview?.addSubview(refresh!)
       
        self.basevctableview?.reloadData()
        navbar.titleView=navibtn
    }
    
}

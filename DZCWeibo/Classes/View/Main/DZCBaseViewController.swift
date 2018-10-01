//
//  DZCBaseViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCBaseViewController: UIViewController {
    
    var basevctableview:UITableView?
    
    var refresh :UIRefreshControl?
    //标记刷新状态
    var isrefresh = false
    //标记访客状态
    var isvisitor = true
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
        
        basevctableview?.dataSource=self
        basevctableview?.delegate=self
        view.addSubview(mynaviBar)
        mynaviBar.items=[navbar]
        isvisitor ? setupVisitorView():setupTableview()
        
    }
    @objc private func loadinfo(){
        print("加载了数据")
    }
    
    override var title: String?{
        
        didSet {
            navbar.title=title
        }
    }
    
    private func setupTableview(){
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
        refresh?.addTarget(self, action: #selector(loadinfo), for: .valueChanged)
        basevctableview?.addSubview(refresh!)
        
        
    }
    private func setupVisitorView(){
        let visitorview = DZCVistorView()
       
        visitorview.visitordictionary=self.visitordict
       
        view.insertSubview(visitorview, belowSubview: mynaviBar)
        
    }
}
extension  DZCBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = tableView.numberOfSections-1
        let count = tableView.numberOfRows(inSection: section)
        
        if row<0||section<0 {
            print("没有任何数据")
            return
        }
        if row==(count-1) && isrefresh==false {
            print("上啦刷新")
        }
        
    }
    
}

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
    
    lazy var mynaviBar:UINavigationBar={
        let bar=UINavigationBar()
        bar.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: 64)
        
        return bar
    }()
    
    lazy var navbar=UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basevctableview?.dataSource=self
        basevctableview?.delegate=self
        view.addSubview(mynaviBar)
        mynaviBar.items=[navbar]
        setupTableview()
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
}
extension  DZCBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        return cell
    }
    
    
}

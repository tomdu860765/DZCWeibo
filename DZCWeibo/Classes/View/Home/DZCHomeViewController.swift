//
//  DZCHomeViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCHomeViewController: DZCBaseViewController {
  private lazy var viwemodel = WeiBoListArrayModel()
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        naviitem()
        refresh?.addTarget(self, action: #selector(loadinfo), for: .valueChanged)
        basevctableview?.dataSource=self
        basevctableview?.delegate=self
        
        self.viwemodel.loadarray(ispull: true) { (issuccess,refreashcount)  in
                self.refresh?.endRefreshing()
                self.isrefresh=false
            //异步回调到主现程刷新界面要使用EXECUTE:
           
            DispatchQueue.main.async(execute: {
                self.basevctableview?.reloadData()
            })
            
            }
        
    }
    @objc private func loadinfo(){
        refresh?.endRefreshing()
        viwemodel.loadarray(ispull: true) { (issuccess,refreashcount) in
            self.refresh?.endRefreshing()
           
            self.basevctableview?.reloadData()
            
            self.isrefresh=false
        }
    }
    @objc private func frientsview(){
        let friendsdemovc = DZCTestViewController()
        navigationController?.pushViewController(friendsdemovc, animated: true)
        
    }
    
    private func naviitem(){
        if (basevctableview == nil){
            return
        }else
        {
        navbar.leftBarButtonItem=UIBarButtonItem(title: "好友", action:#selector(frientsview),
                                                         target: self, normalcolor: UIColor.darkGray,
                                                         highlightedcolor: UIColor.orange)}
        
    }

    

}
extension  DZCHomeViewController:UITableViewDataSource,UITableViewDelegate{


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viwemodel.listarray.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
       
        cell.textLabel?.text=viwemodel.listarray[indexPath.row].text
       
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
            
            loadinfo()
        }

}
}

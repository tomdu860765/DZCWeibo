//
//  DZCHomeViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCHomeViewController: DZCBaseViewController,TextAttristringDelegate {
    private lazy var viwemodel = WeiBoListArrayModel()
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        naviitem()
        refresh?.addTarget(self, action: #selector(loadinfo), for: .valueChanged)
        basevctableview?.dataSource=self
        basevctableview?.delegate=self
        loadinfo()

        
    }
    @objc private func loadinfo(){
        refresh?.beginRefreshing()
        viwemodel.loadarray(ispull: true) { (issuccess,refreashcount) in
            
            DispatchQueue.main.async(execute: {
                self.basevctableview?.reloadData()
            })
            self.isrefresh=false
           self.refresh?.endRefreshing()
            
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
        var cellid = ""
        if viwemodel.listarray[indexPath.row].weibomodel.retweeted_status==nil {
            cellid = "cellid"
        }else{
            cellid = "repostid"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellid , for: indexPath) as! DZCWeiboTableViewCell
        cell.viewmodel=viwemodel.listarray[indexPath.row]
        cell.delegate = self
       
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
        if row==(count-1) && ispullup==false {
            ispullup=true
            loadinfo()
        }

}
    
  func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let  modelarray = viwemodel.listarray[indexPath.row]
       
        return modelarray.weibocellheight
    }
 
}
extension DZCHomeViewController{
    
    
    func  DZCweiboTextAttristringCell(cell: DZCWeiboTableViewCell, urlstring: String) {
       
        let webvc=DZCWebViewController()
        webvc.urlstring = urlstring
        
        navigationController?.pushViewController(webvc, animated: true)
        
    }
    
    
}

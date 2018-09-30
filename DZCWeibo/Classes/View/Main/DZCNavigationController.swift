//
//  DZCNavigationController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

   self.navigationBar.isHidden=true
    
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        if children.count>0 {
             viewController.hidesBottomBarWhenPushed=true
        }
       
       
        if let vc = viewController as? DZCBaseViewController{
            var title = ""
            if children.count==1{
               title = children.first?.title ?? "返回"
                
            }
            
           vc.navbar.leftBarButtonItem=UIBarButtonItem.init(title: title, action: #selector(getback),
                                                                                        target: self, normalcolor: UIColor.darkGray, highlightedcolor: UIColor.orange)
        }
         super.pushViewController(viewController, animated: true)
    }
   
    @objc private func getback(){
        
        popViewController(animated: true)
        
    }

}


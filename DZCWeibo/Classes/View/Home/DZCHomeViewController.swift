//
//  DZCHomeViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCHomeViewController: DZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        naviitem()
        
    }
    
    @objc private func frientsview(){
        let friendsdemovc = DZCTestViewController()
        navigationController?.pushViewController(friendsdemovc, animated: true)
        
    }
    
    private func naviitem(){
      
  
        navbar.leftBarButtonItem=UIBarButtonItem(title: "好友", action:#selector(frientsview),
                                                         target: self, normalcolor: UIColor.darkGray,
                                                         highlightedcolor: UIColor.orange)
    }
   

}


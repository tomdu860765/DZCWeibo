//
//  DZCBaseViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCBaseViewController: UIViewController {
    lazy var mynaviBar:UINavigationBar={
        let bar=UINavigationBar()
        bar.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: 88)
       
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

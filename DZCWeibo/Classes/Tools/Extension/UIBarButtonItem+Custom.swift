//
//  UITabBarItem+Custom.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/28.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    ///便利UITabBarItem构造器
    ///
    ///*参数一 按钮标题
    ///*参数二 执行方法
    ///*参数三 监听目标
    ///*参数四 正常状态颜色
    ///*参数五 高亮状态颜色
    convenience init(title:String,action:Selector,target:Any?,normalcolor:UIColor,highlightedcolor:UIColor) {
        
        let btn = UIButton()
        btn.setTitleColor(normalcolor, for:.normal)
        btn.setTitleColor(highlightedcolor, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for:.normal)
        
        self.init(customView: btn)
       
    }
    
   
    
    
}


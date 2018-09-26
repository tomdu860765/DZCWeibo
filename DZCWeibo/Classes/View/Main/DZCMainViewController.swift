//
//  DZCMainViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
    }
    
    
    
}
extension DZCMainViewController{
    //子类方法,要实例化使用,类似分类
     func tabbarsubsvc()->DZCTabBarViewController{
        let tabbararray = [
            ["classVC":"DZCHomeViewController","title":"首页","image":"home"],
             ["classVC":"DZCDiscoverController","title":"发现","image":"discover"],
             ["classVC":"DZCMessageViewController","title":"信息","image":"message_center"],
             ["classVC":"DZCMyinfoViewController","title":"我","image":"profile"]
        ]
        var marray = [UIViewController]()
        
        for dict in tabbararray {
            
            marray.append(subsVC(dict:dict))
        }
        
        let tabbar = DZCTabBarViewController()
        
        tabbar.viewControllers=marray
        return tabbar
    }
    
    
    
    private func subsVC(dict:[String:String])->UIViewController{
        //根据字典名称创建控制器
        let str = Bundle.main.infoDictionary?["CFBundleName"]as? String ?? ""
        //tabbar_compose_button_highlighted,tabbar_discover
        
        
        guard let clsname=dict["classVC"],let title=dict["title"],let image=dict["image"],
            let clsvc=NSClassFromString(str+"."+clsname)as?UIViewController.Type
            else
        {
            return UIViewController()
            
        }
        let strimage="tabbar"+"_"+image
        let vc = clsvc.init()
        vc.title=title
        vc.tabBarItem.image=UIImage.init(named: strimage)
        vc.tabBarItem.selectedImage=UIImage.init(named: strimage+"_"+"highlighted")?.withRenderingMode(.alwaysOriginal)
        let navivc = DZCNavigationController.init(rootViewController: vc)
        
        return navivc
        
    }
    
    
    
    
    
    
    
}

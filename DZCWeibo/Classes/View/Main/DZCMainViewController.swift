//
//  DZCMainViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarsubsvc()
        setbutton()
    }
    @objc private func showvc(){
        
        print("我被点击了")
    }
    private lazy var button:UIButton = {
        let btn=UIButton()
        btn.setBackgroundImage(UIImage.init(named:"tabbar_compose_button"), for:.normal)
        btn.setBackgroundImage(UIImage.init(named:"tabbar_compose_button_highlighted"), for:.selected)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: .selected)
        
        btn.addTarget(self, action: #selector(showvc), for:.touchUpInside)
        return btn
    }()
    
}
extension DZCMainViewController{
    //在load哪里添加执行方法
    
    private func setbutton(){
        let count = CGFloat(children.count)
        let widthsubsview = tabBar.bounds.width/count-1
        
        button.frame=tabBar.bounds.insetBy(dx: 2*widthsubsview, dy: 0)
        tabBar.addSubview(button)
    }
    
    
    
    private  func tabbarsubsvc(){
        let tabbararray = [
            ["classVC":"DZCHomeViewController","title":"首页","image":"home"],
            ["classVC":"DZCDiscoverController","title":"发现","image":"discover"],
            ["classVC":"UIViewController","title":"添加"],
            ["classVC":"DZCMessageViewController","title":"信息","image":"message_center"],
            ["classVC":"DZCMyinfoViewController","title":"我","image":"profile"]
        ]
        var marray = [UIViewController]()
        
        for dict in tabbararray {
            
            marray.append(subsVC(dict:dict))
        }
        
        
        viewControllers=marray
        
        
        
    }
    
    
    
    private func subsVC(dict:[String:String])->UIViewController{
        //根据字典名称创建控制器
        let str = Bundle.main.infoDictionary?["CFBundleName"]as? String ?? ""
        
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
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for:.selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], for:.normal)
        
        
        
        
        let navivc = DZCNavigationController(rootViewController: vc)
        
        
        
        return navivc
        
    }
    
    
    
    
    
    
    
}

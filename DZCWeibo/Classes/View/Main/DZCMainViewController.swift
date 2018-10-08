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
        delegate=self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginshowtableview),
                                               name: NSNotification.Name(rawValue: UserNotification),
                                               object: nil)
        
    }

    @objc private func showvc(){
        
        print("我是添加微博")
        
    }
    @objc private func loginshowtableview(){
        
        print(NSNotification.Name.self)
        let webvc = UINavigationController.init(rootViewController: DZCWebView())
      
        
        self.present(webvc, animated: true, completion: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
 
    
    private lazy var button:UIButton = {
        let btn=UIButton.init(NormalBackgroundImage: "tabbar_compose_button",
                              Image: "tabbar_compose_icon_add",
                              SelectedBackgroundImage: "tabbar_compose_button_highlighted",
                              SelectedImage: "tabbar_compose_icon_add_highlighted")

        
        btn.addTarget(self, action: #selector(showvc), for:.touchUpInside)
        return btn
    }()
   
    
}
extension DZCMainViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        let index = (viewControllers! as NSArray).index(of: viewController)
        if selectedIndex==0 && selectedIndex==index {
            print("点击首页")
            let navvc = viewControllers?.first as! UINavigationController
            let vc = navvc.viewControllers.first as! DZCHomeViewController
            vc.basevctableview?.setContentOffset(CGPoint.init(x: 0, y: -64), animated: true)
         
        }
        
       return !viewController.isMember(of: UIViewController.self)
        
    }
    
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
        
        
        let doucpath = documentpath
        let strrul = (doucpath! as NSString).appendingPathComponent("main.json")
        let dataurl = URL.init(fileURLWithPath: strrul)
        var dataruljson = try? Data.init(contentsOf: dataurl)
        if  dataruljson==nil {
            let path=Bundle.main.url(forResource: "BaseView.json", withExtension: nil)
           
            dataruljson = try? Data.init(contentsOf: path!)
        }
   guard    let tabbararray = try? JSONSerialization.jsonObject(with: dataruljson!, options: .mutableContainers) as?[[String:Any]]
            else {

          print("编译json文件失败")
           return
       }
        
        var marray = [UIViewController]()
        
        for dict in tabbararray! {
            
            marray.append(subsVC(dict:dict))
        }
        
        
       viewControllers=marray
        
        
    }
    
    
    
    private func subsVC(dict:[String:Any])->UIViewController{
        //根据字典名称创建控制器
        let str = Bundle.main.infoDictionary?["CFBundleName"]as? String ?? ""
        
        guard let clsname=dict["classVC"]as?String,
            let title=dict["title"]as?String,
            let image=dict["image"]as?String,
            let clsvc=NSClassFromString(str+"."+clsname)as?DZCBaseViewController.Type,
            let basevcdict = dict["visitorinfo"]as?[String:String]
            else
        {
            return UIViewController()
            
        }
        let strimage="tabbar"+"_"+image
        let vc = clsvc.init()
        vc.visitordict=basevcdict
        vc.title=title
        vc.tabBarItem.image=UIImage.init(named: strimage)
        vc.tabBarItem.selectedImage=UIImage.init(named: strimage+"_"+"highlighted")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for:.selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], for:.normal)
        
        
        
        
        let navivc = DZCNavigationController(rootViewController: vc)
        
        
        
        return navivc
        
    }
    
}

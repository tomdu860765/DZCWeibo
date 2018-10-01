//
//  AppDelegate.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window=UIWindow()
        
        //实例化子类方法作为rootVC使用
    
        
        self.window?.rootViewController=DZCMainViewController()
        self.window?.backgroundColor=UIColor.white
        self.window?.makeKeyAndVisible()
        setdataForbaseVC()
        return true
    }

   
  
}
extension AppDelegate{
    
    private func setdataForbaseVC(){
        
        //模拟判断需不需要在网络上加载文件
    
        let path=Bundle.main.url(forResource: "BaseView.json", withExtension: nil)
        let jsondata = try? Data.init(contentsOf: path!)
        
        let doucpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let strrul = (doucpath! as NSString).appendingPathComponent("main.json")
        let doucurl = URL.init(fileURLWithPath: strrul)
        try? jsondata?.write(to: doucurl)
        
    }
    
    
    
}

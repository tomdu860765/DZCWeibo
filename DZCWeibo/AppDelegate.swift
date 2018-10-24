//
//  AppDelegate.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
   
    let  userversionnew =  UserDefaults.standard.object(forKey:"Version") as? String
  
    let uservesion = infoCFBundleVersion
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window=UIWindow()
        
        self.window?.backgroundColor=UIColor.white
        Versionofvc()
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
    /// 该方法判断版本号是否相同,执行该方法
    
    private func Versionofvc(){
        
  
        if userversionnew != uservesion {
            
            let layout = UICollectionViewFlowLayout()
            
            self.window?.rootViewController=DZCCollectionViewController(collectionViewLayout:layout)
            
             UserDefaults.standard.set(infoCFBundleVersion, forKey: "Version")
           
        }else
            
        {
            //如果并非新版本从欢迎页面进入
            let welcomevc=UIStoryboard.init(name:"WelcomeView" , bundle: .main).instantiateViewController(withIdentifier: "welcomesb")
            self.window?.rootViewController = welcomevc
            //self.window?.rootViewController=DZCMainViewController()
            self.window?.backgroundColor=UIColor.white
            
        }

    }
   
    
}

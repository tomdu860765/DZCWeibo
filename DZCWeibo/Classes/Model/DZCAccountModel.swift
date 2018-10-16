//
//  DZCAccountModel.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/7.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
@objcMembers
class DZCAccountModel: NSObject {
    //用户模型信息
    var access_token :String?
    
    var expires_in : TimeInterval = 0 {
        
        didSet{
            
            expiresdata = Date.init(timeIntervalSinceNow:expires_in)
        }
        
    }
    //用户uid
    var  uid : String?
    //过期时间
    var expiresdata :Date?
    //用户昵称
    var screen_name : String?
    //用户头像地址
    var avatar_large : String?
    
    override var description: String{
        
        return yy_modelDescription()
        
    }
    //初始化模型方法
    override init() {
        super.init()
        
        guard  let strpath = (documentpath as NSString?)?.appendingPathComponent("account.json") else{
            print("没有该文件")
            return
        }
        let url = URL.init(fileURLWithPath: strpath)
        
        let json = try? JSONSerialization.jsonObject(with: Data.init(contentsOf: url), options: .allowFragments)
        
        self.yy_modelSet(withJSON: json as Any)
        
        if expiresdata?.compare(Date.init()) != .orderedDescending
        {
            access_token=nil
            expiresdata=nil
            uid=nil
            print("账户过期,请重新登录")
        }
        
    }
    
    
    //保存模型方法
    func saveaccount() {
        
        var dictionaryaccount = self.yy_modelToJSONObject() as? [String:AnyObject]
        
        dictionaryaccount?.removeValue(forKey: "expires_in")
        
        let accountdata = try? JSONSerialization.data(withJSONObject: dictionaryaccount as Any, options: .prettyPrinted)
        
        guard  let strpath = (documentpath as NSString?)?.appendingPathComponent("account.json")else{
            
            print("写入错误")
            return
        }
        
        let url = URL.init(fileURLWithPath:strpath)
        
        try?  accountdata?.write(to: url)
        print("写入成功")
    }
    
}


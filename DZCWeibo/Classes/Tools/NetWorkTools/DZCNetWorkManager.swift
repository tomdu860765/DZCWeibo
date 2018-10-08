//
//  DZCNetWorkManager.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/3.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import AFNetworking

enum NetWorkWays {
    case GET
    case POST
}

class DZCNetWorkManager: AFHTTPSessionManager {
    
     static let DefaultNetWork=DZCNetWorkManager()
    
    //加载自定义模型
   lazy var account=DZCAccountModel()
   
    lazy var signin:Bool={
   
       return account.access_token != nil
    }()
    
   //处理token的方法
    func tokenrequest(Method:NetWorkWays,URLString:String,Token:[String:Any]?,Completion:@escaping (AnyObject?,Bool)->())  {
        
        guard let weibotoken=account.access_token else {
            print("请用账号登陆")
            Completion(nil,false)
            return
        }

        var Token = Token
        if Token==nil {
            Token=[String:Any]()
        }
        //拼接字典
        Token?["access_token"]=weibotoken
        
        
        
        NetWeiboHomeInfo(Method:.GET,URLString: URLString, Token: Token!, Completion:Completion)
    }
    
    

    
    func NetWeiboHomeInfo(Method:NetWorkWays,URLString:String,Token:[String:Any],Completion:@escaping (AnyObject?,Bool)->())  {
        let Success = {
            (task:URLSessionDataTask,json:Any?)->() in
            Completion(json as AnyObject,true)
        }
        let Failure = {
            (tasks:URLSessionDataTask?,error:Error)->() in
            if ( tasks?.response as? HTTPURLResponse)?.statusCode==403 {
               print("账户过期请重新登录")
            }
            print("网络请求失败\(error)")
            Completion(error as AnyObject,false)
        }
        switch Method{
        case  .GET: do {
            DZCNetWorkManager.DefaultNetWork.get(URLString, parameters: Token, progress: nil,
                                                 success: Success,
                                                 failure: Failure)
           print("Get方法被执行")
        }
        case .POST: do {
          DZCNetWorkManager.DefaultNetWork.post(URLString, parameters: Token,
                                                 progress: nil,
                                                 success: Success,
                                                 failure: Failure)
            print("post方法被执行")
        }
        }
        
    }

    
    
}

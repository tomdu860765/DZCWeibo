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
    
    var paratoken:String?="2.00gBnWYF0o747s05b99814f5gdeNeC"
   
   //处理token的方法
    func tokenrequest(Method:NetWorkWays = .GET,URLString:String,Token:[String:Any]?,Completion:@escaping (AnyObject?,Bool)->())  {
        
        guard let weibotoken=paratoken else {
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
        
        
        
        NetWeiboHomeInfo(URLString: URLString, Token: Token!, Completion:Completion)
    }
    
    

    
    func NetWeiboHomeInfo(Method:NetWorkWays = .GET,URLString:String,Token:[String:Any],Completion:@escaping (AnyObject?,Bool)->())  {
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
        
        if NetWorkWays.GET == .GET {
            DZCNetWorkManager.DefaultNetWork.get(URLString, parameters: Token, progress: nil,
                                                 success: Success,
                                                 failure: Failure)
           
        }
      else
        {  DZCNetWorkManager.DefaultNetWork.post(URLString, parameters: Token,
                                                 progress: nil,
                                                 success: Success,
                                                 failure: Failure)
        }

        
    }

    
    
}

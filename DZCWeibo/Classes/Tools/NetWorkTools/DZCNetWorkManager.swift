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
   
   
    
   //处理token的方法
    func tokenrequest(Method:NetWorkWays,URLString:String,Token:[String:Any]?,name:String?=nil,data:Data?=nil, Completion:@escaping (AnyObject?,Bool)->())  {
        
        guard let weibotoken=account.access_token else {
            print("请用账号登陆")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserExtimeNotification),
                                            object: nil, userInfo: nil)
            Completion(nil,false)
            return
        }

        var Token = Token
        if Token==nil {
            Token=[String:Any]()
        }
        //拼接字典
        Token?["access_token"]=weibotoken
        if let name=name,
            let data=data
         {
            uploadweibo(URLString: URLString, TokenDict: Token!, data: data, name: name, Completion: Completion)
        }else{
            //fix的网络方法修改
            NetWeiboHomeInfo(Method:.GET,URLString: URLString, Token: Token!, Completion:Completion)
        }
  
    }
    
    //上传微博方法
    func uploadweibo(URLString:String,TokenDict:[String:Any]?,data:Data,name:String,Completion:@escaping (AnyObject?,Bool)->())   {
        
        
        post(URLString, parameters: TokenDict, constructingBodyWith: { (AFMultipartFormData) in
            AFMultipartFormData.appendPart(withFileData: data, name: name, fileName: "picname", mimeType: "application/octet-stream")
        }, progress: nil, success: { (_, json) in
          //成功回调
            Completion(json as AnyObject,true)
        }) { (tasks:URLSessionDataTask?,error:Error) in
            //失败回调
            if ( tasks?.response as? HTTPURLResponse)?.statusCode==403 {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserExtimeNotification),
                                                object: nil, userInfo: nil)
                print("账户过期请重新登录")
            }
            print("网络请求失败\(error)")
            Completion(error as AnyObject,false)
        }
        
        
        
        
        
    }
    
    

    
    func NetWeiboHomeInfo(Method:NetWorkWays,URLString:String,Token:[String:Any],Completion:@escaping (AnyObject?,Bool)->())  {
        let Success = {
            (task:URLSessionDataTask,json:Any?)->() in
            Completion(json as AnyObject,true)
        }
        let Failure = {
            (tasks:URLSessionDataTask?,error:Error)->() in
            if ( tasks?.response as? HTTPURLResponse)?.statusCode==403 {
               
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserExtimeNotification),
                                                object: nil, userInfo: nil)
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
           
        }
        case .POST: do {
          DZCNetWorkManager.DefaultNetWork.post(URLString, parameters: Token,
                                                 progress: nil,
                                                 success: Success,
                                                 failure: Failure)
            
        }
        }
        
    }

    
    
}

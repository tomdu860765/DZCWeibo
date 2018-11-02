//
//  DZCNetWorkManager+JsonWeibo.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
import UIKit
extension DZCNetWorkManager{
    
    ///max_id:返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    ///since_id:ID小于或等于max_id的微博，默认为0。
    func WeiBoRequest(since_id:Int64=0,max_id:Int64=0,completion:@escaping (_ listarray:[[String:AnyObject]]?,_ issuccess:Bool)->()) {
        let str = "https://api.weibo.com/2/statuses/home_timeline.json"
        let tokendictid = ["since_id":since_id,"max_id":max_id]
        
        tokenrequest(Method: .GET, URLString: str, Token: tokendictid) { (json, issuccess) in
            
            
            let dictweibojson=json?["statuses"] as? [[String:AnyObject]]
            
            completion(dictweibojson,issuccess)
            
        }
        
    }
    
    
}
extension DZCNetWorkManager{
    
     func usersignin(code:String,completion:@escaping (Bool)->()) {

        let codepath = "https://api.weibo.com/oauth2/access_token"
        
        let tokendictpost = ["client_id":userid,
                             "client_secret":usercode,
                             "grant_type":"authorization_code",
                             "code":code,
                             "redirect_uri":useruri]
        
        
        NetWeiboHomeInfo(Method:NetWorkWays.POST, URLString:codepath, Token: tokendictpost) { (json, issuccess) in
            
           //字典转模型
            self.account.yy_modelSet(withJSON: json as? [String:AnyObject] ?? [:] )
          
            
            self.usernameandpic(completion: { (json) in
                self.account.yy_modelSet(with: json)
                
                //保存模型
                self.account.saveaccount()
               
                  completion(issuccess)
                
            })
        
                 }
        
    }
    
    private   func usernameandpic(completion:@escaping (([String:AnyObject])->())) {
        let url = "https://api.weibo.com/2/users/show.json"
        let tokeninfo = ["uid":account.uid,"access_token":account.access_token]
    
        tokenrequest(Method: .GET, URLString: url, Token: tokeninfo as! [String : String] ) { (infojson, issuccess) in
   
            if issuccess==true
            {
                completion(infojson as?[String:AnyObject] ?? [:])
            }
    
            
        }
        
    }
    //发布微博请求处理
    func postweibonetwork(text:String,image:UIImage?,completion:@escaping (([String:AnyObject],Bool)->()))  {
       let urlstr="https://api.weibo.com/2/statuses/share.json"
        
        let prmas = ["status":text,"access_token":account.access_token]
        
        
        if image != nil {
            let name : String? = "pic"
            let data : Data? = image!.pngData()
            tokenrequest(Method: NetWorkWays.POST, URLString: urlstr, Token: prmas as [String : Any], name: name, data: data) { (json, issuccess) in
                completion(json as! [String : AnyObject], issuccess)
            }
        }else{
            
            tokenrequest(Method: NetWorkWays.POST, URLString: urlstr, Token: prmas as [String : Any]) { (json, issuccess) in
                completion(json as! [String : AnyObject], issuccess)
            }
            
        }
        

    }

}

//
//  DZCNetWorkManager+JsonWeibo.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
extension DZCNetWorkManager{
    
    func WeiBoRequest(completion:@escaping (_ listarray:[[String:AnyObject]]?,_ issuccess:Bool)->()) {
        let str = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenrequest(URLString: str, Token: nil) { (json, issuccess) in
            
            
            let dictweibojson=json?["statuses"] as? [[String:AnyObject]]
            
            completion(dictweibojson,issuccess)
            
        }
        
    }
    
    
}

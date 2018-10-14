//
//  DZCWeiboDetailsModel.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/12.
//  Copyright © 2018 tomdu. All rights reserved.
//
///微博详情模型
import UIKit
@objcMembers
class DZCWeiboDetailsModel: NSObject {
    //用户id
    var id : Int64 = 0
    //用户昵称
    var screen_name : String?
    //用户头像连接
    var profile_image_url : String?
    //用户认证类型
    var verified_type : Int = 0
    //用户等级
    var mbrank : Int = 0
    

   
    
    
    override var description: String{
        
        
        return yy_modelDescription()
    }
}

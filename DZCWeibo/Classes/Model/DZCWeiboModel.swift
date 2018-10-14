//
//  DZCWeiboModel.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import YYModel
@objcMembers
class DZCWeiboModel: NSObject {

    var id : Int64=0
    
    var text:String?
    
    //消息来源
    var source : String?
    //user返回模型
    var user : DZCWeiboDetailsModel?
    
    //转发数
    var  reposts_count : Int = 0
    //评论数
    var comments_count : Int = 0
    // 表态数
    var  attitudes_count  : Int = 0
    
    var   pic_urls : [DZCPicModel]?
    
    //微博创建时间
    var created_at : String?
    
    override var description: String{
        
        return yy_modelDescription()
        
    }
    class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        
        
        return ["pic_urls":DZCPicModel.self]
        
    }
    
    
}

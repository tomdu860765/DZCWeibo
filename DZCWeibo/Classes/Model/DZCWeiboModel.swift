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
    
    override var description: String{
        
        return yy_modelDescription()
        
    }
    
    
}

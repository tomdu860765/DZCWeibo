//
//  DZCEmotionModel.swift
//  DZCRegularExpression
//
//  Created by tomdu on 2018/10/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import YYModel
@objcMembers
class DZCEmotionModel: NSObject {
   //用作本地图文
    var png : String?
    //服务器图文
    var chs : String?
   
    var type : Bool = false
    
    var code : String?
    //增加一个目录读取plist
    var id :String?
    //增加一个uiimage属性
    var image : UIImage? {
        
        
            if type  {
                return nil
            }
            
            guard let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
            let bundel = Bundle.init(path: path)
        
                else {
                return nil

        }
        //可选类型变更非可选类型
        let imagestring = "\(id ?? " ")/\(png ?? " ")"
        
      
        return UIImage.init(named:imagestring , in: bundel, compatibleWith: nil)
            
            
        
        
    }
    func imagetext(font:UIFont) -> NSAttributedString {
        let arrachment = NSTextAttachment()
        if image != nil {
            
            arrachment.image = image
            let fontheight = font.lineHeight
            arrachment.bounds = CGRect(x: 0, y: -4, width: fontheight, height: fontheight)
            
        }

     return NSAttributedString(attachment: arrachment)
    }
    
    
    
    override var description: String{
        
        return yy_modelDescription()
        
    }
    
}

//
//  UIButton+Image.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

extension UIButton{
    ///便利UIButton构造器
    ///
    ///*参数一 背景图片
    ///*参数二 正常状态图片
    ///*参数三 点击背景图片
    ///*参数四 点击图片
    
    convenience init(NormalBackgroundImage:String,Image:String,SelectedBackgroundImage:String,SelectedImage:String){
        self.init()
        
        self.setBackgroundImage(UIImage.init(named:NormalBackgroundImage), for:.normal)
        self.setBackgroundImage(UIImage.init(named:SelectedBackgroundImage), for:.selected)
        self.setImage(UIImage.init(named: Image), for: .normal)
        self.setImage(UIImage.init(named: SelectedImage), for: .selected)
        self.sizeToFit()
        
    }
    
    
    
    
    
    
    
}

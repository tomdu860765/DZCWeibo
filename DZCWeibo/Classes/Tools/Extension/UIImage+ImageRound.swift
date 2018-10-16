//
//  UIImage+ImageRound.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

extension UIImage{
    
    func ImageRoundCut(size:CGSize,backcolor:UIColor=UIColor.white) -> UIImage {
        let rect = CGRect(origin: CGPoint.init(), size: size)
        UIGraphicsBeginImageContextWithOptions(size,true,0)
        
        let path = UIBezierPath.init(ovalIn: rect)
       
        //填充背景颜色
        backcolor.setFill()
        UIRectFill(rect)
        
        //先填充背景色,再截图
        path.addClip()
        draw(in: rect)
       
        //画线
        UIColor.black.setStroke()
        path.lineWidth=2
        path.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        
        
        UIGraphicsEndImageContext()
        
        return result!
    }
    
    
    
}

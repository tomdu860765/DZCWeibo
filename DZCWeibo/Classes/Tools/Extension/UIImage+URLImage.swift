//
//  UIImage+ImageName.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/27.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImageView{
    
    func imageview(urlstring:String,iamge:UIImage?,issuccess:Bool)  {
        
        let urlstr = URL.init(string:urlstring)
        
        sd_setImage(with: urlstr,
                    placeholderImage: image,
                    options: []) { (image, _, _, _) in
                        
                        if issuccess==true{
                        self.image = image?.ImageRoundCut(size:self.frame.size)
                            
                        }
      
        }
    }
    
    
}

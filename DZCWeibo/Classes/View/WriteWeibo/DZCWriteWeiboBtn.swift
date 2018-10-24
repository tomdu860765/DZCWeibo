//
//  DZCWriteWeiboBtn.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/21.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCWriteWeiboBtn: UIControl {

    @IBOutlet weak var btnimage: UIImageView!
    
    @IBOutlet weak var btnlabel: UILabel!
    
    
    class func creatbtn(imagename:String,title:String)->DZCWriteWeiboBtn{
        let btnview = UINib.init(nibName: "DZCWriteWeiboBtn", bundle: nil).instantiate(withOwner: nil, options: nil).last as! DZCWriteWeiboBtn
        
        btnview.btnimage.image = UIImage.init(named: imagename)
        btnview.btnlabel.text = title
        
        return btnview
        
    }
    
    
    
    
}

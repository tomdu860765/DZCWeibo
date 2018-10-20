//
//  DZCRefreashview.swift
//  FreshControl
//
//  Created by tomdu on 2018/10/20.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCRefreashview: UIView {
    //枚举状态属性
    var status : viewstatus = .normal{
        
        didSet{
            switch status{
            case .normal: titlelabel.text="向下拉刷新"
            UIView.animate(withDuration: 0.25) {
                self.loadimageview.transform = CGAffineTransform.identity
            }
            
            loadview.isHidden=true
            loadimageview.isHidden=false
            loadview.stopAnimating()
            case .pulling : titlelabel.text="再往下拉就可以刷新"
            UIView.animate(withDuration: 0.25) {
                self.loadimageview.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
                
                }
                
                
                
            case .stop : titlelabel.text="放手刷新"
            loadview.isHidden=false
            loadimageview.isHidden=true
            loadview.startAnimating()
            }
        }
        
    }
    
    //旋转动画
    @IBOutlet weak var loadview: UIActivityIndicatorView!
    //文字提示
    @IBOutlet weak var titlelabel: UILabel!
    //箭头图片
    
    @IBOutlet weak var loadimageview: UIImageView!
    
    class func creatview()->DZCRefreashview{
        let uib = UINib.init(nibName:"DZCRefreshControl" , bundle: nil)
        
        
        return uib.instantiate(withOwner: nil, options: nil).last as! DZCRefreashview
        
    }
    
    
}

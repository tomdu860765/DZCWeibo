//
//  DZCVistorView.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/9/30.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import SnapKit

class DZCVistorView: UIView {
    var  visitordictionary:[String:String]?{
        didSet{
            guard let message=visitordictionary?["message"],
                  let imagename = visitordictionary?["imagename"]
            else {
                
                return
            }
           messagelabel.text=message
           
            if imagename=="" {
                return
            }else{
                hourseimage.image=UIImage.init(named: imagename)
                feedimage.isHidden=true
            }
            
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setvisitorview()

          feedimageanmiation()        }
    
    required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    //赖加载控件
    private lazy var loginbutton:UIButton={
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.sizeToFit()
        button.frame.origin.x=self.center.x-70
        button.frame.origin.y=self.center.y-20
   
        return button
    }()
    private lazy var registerbutton:UIButton={
        let button=UIButton()
        button.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.sizeToFit()
        button.frame.origin.x=self.center.x+30
        button.frame.origin.y=self.center.y-20
        return button
    }()
    private lazy var hourseimage:UIImageView={
        let imageview=UIImageView()
        imageview.image=UIImage.init(named: "visitordiscover_feed_image_house")
        imageview.sizeToFit()
      imageview.frame.origin.x=self.center.x-50
      imageview.frame.origin.y=self.center.y-160
        imageview.isUserInteractionEnabled=false
      
        return imageview
    }()
    private lazy var feedimage:UIImageView={
        let imageview=UIImageView()
        imageview.image=UIImage.init(named: "visitordiscover_feed_image_smallicon")
        imageview.sizeToFit()
        imageview.frame.origin.x=hourseimage.center.x-88
        imageview.frame.origin.y=hourseimage.center.y-80
        imageview.isUserInteractionEnabled=false
        return imageview
    }()
    private lazy var messagelabel:UILabel={
        let label=UILabel()
        label.text="我是视图一,欢迎登陆微博,打开另一个世界"
        label.numberOfLines=0
        label.frame=CGRect(x: self.center.x-120, y: self.center.y, width: 200, height: 100)

        
        return label
    }()
    
}
extension DZCVistorView{
    
 private   func setvisitorview()  {
        let viewheight = UIScreen.main.bounds.size.height-158
        translatesAutoresizingMaskIntoConstraints=false
        frame=CGRect(x: 0, y: 74, width: UIScreen.main.bounds.size.width, height: viewheight)
        self.addSubview(loginbutton)
        self.addSubview(registerbutton)
        self.addSubview(hourseimage)
        self.addSubview(feedimage)
        self.addSubview(messagelabel)
        self.backgroundColor=UIColor.white

    }
private   func feedimageanmiation ()  {
   
    let feedanmiation = CABasicAnimation.init(keyPath: "transform.rotation")
    feedanmiation.toValue = Double.pi*2
    feedanmiation.repeatCount=MAXFLOAT
    feedanmiation.duration=15
    feedanmiation.isRemovedOnCompletion=false
    feedimage.layer.add(feedanmiation, forKey: nil)
    }
    
}

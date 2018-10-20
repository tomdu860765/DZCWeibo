//
//  DZCDetalisViewModel.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
import UIKit
class DZCDetalisViewModel:CustomStringConvertible {

    var weibomodel : DZCWeiboModel
    
    var headicon : UIImage?
    
    var vipimage : UIImage?
    
    var recount : String?
   
    var comcount : String?
    
    var likecount : String?
    //图片高度
    var picsize = CGSize()
    
    var vipicon : UIImage?
    
    var imageurls : [DZCPicModel]?{
        
        return weibomodel.retweeted_status?.pic_urls  ?? weibomodel.pic_urls
    }
    var retweetedtext :String?
    //计算行高
    var weibocellheight : CGFloat=0
    
    
    init(model:DZCWeiboModel) {
        
        self.weibomodel = model
        
        
        if weibomodel.user?.mbrank ?? 0 > 0 || weibomodel.user?.mbrank ?? 0 < 7 {
            let imagename = "common_icon_membership_level\(weibomodel.user!.mbrank)"
            
            vipimage = UIImage.init(named: imagename)
        }
        
        switch weibomodel.user?.verified_type {
        case 0: do {
           vipicon=UIImage.init(named:"avatar_vip")
            }
        case 2,3,5:do{
            
        vipicon=UIImage.init(named: "avatar_enterprise_vip")
            
            }
        case 220:do{
            
            vipicon=UIImage.init(named: "avatar_grassroot")
            }
            
        default:
            break
        }
        //创建时间处理
        //print(weibomodel.created_at as Any)
 
        recount = btncount(count:weibomodel.reposts_count)
        comcount = btncount(count: weibomodel.comments_count)
        likecount = btncount(count: weibomodel.attitudes_count)
        
        picsize=piccountsize(piccount: imageurls?.count ?? 0)
        
        retweetedtext = "@" + (weibomodel.user?.screen_name ?? " ") + (weibomodel.retweeted_status?.text ?? " ")
        
        
        updataheight()
    }
    
 private   func btncount(count:Int,defaultstr:String="") -> String {
        if  count == 0 {
            return defaultstr
        }
        if count<10000 {
            return count.description
        }
    
        
        return (count/10000).description+"万"
    }
    
    private func piccountsize(piccount:Int)->CGSize{
        if piccount==0{
            
            return CGSize.zero
        }
       
        //行数
        let row = (piccount-1)/3+1
        
        let viewhight = outtermargin+CGFloat(row)*itemviewwidth+CGFloat(row-1)*innermargin
        

        return CGSize(width:viewwidth , height: viewhight)
    }
    
    
    var description: String{
        return weibomodel.description
        
    }
    func updataheight()  {
        let margin = CGFloat(12)
        let iconheight = CGFloat(34)
        let toolbarheight = CGFloat (35)
        var height = CGFloat (0)
        //顶部距离
        height = 3*margin+iconheight
        //cell的视图大小测算
        let viewsize = CGSize.init(width: screenbounds.width-2*margin, height:CGFloat(MAXFLOAT))
        
        //微博文本大小
        if let text=weibomodel.text {
        
        height += (text as NSString).boundingRect(with: viewsize, options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                              attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)],
                                    context: nil).height
            
        }
        //转发微博高度
        if  weibomodel.retweeted_status != nil{
            
            height += 2*margin
            if let text = weibomodel.retweeted_status?.text{
            height += (text as NSString).boundingRect(with: viewsize, options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                           attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)],
                                                                           context: nil).height}
        }
        //加上图片高度
        height += picsize.height
        
        height += margin
        
        height += toolbarheight
        
        weibocellheight = height
    }
    
    func updatapic(pic:UIImage){
        var size = pic.size
        size.height += outtermargin
        
        picsize = size
        
        updataheight()
    }
    

}



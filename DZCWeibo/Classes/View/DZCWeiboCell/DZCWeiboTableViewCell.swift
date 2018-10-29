//
//  DZCWeiboTableViewCell.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/12.
//  Copyright © 2018 tomdu. All rights reserved.

import UIKit
//定义使用代理
@objc protocol TextAttristringDelegate:NSObjectProtocol{
    
    @objc  optional func DZCweiboTextAttristringCell(cell:DZCWeiboTableViewCell,urlstring:String)
    
}

class DZCWeiboTableViewCell: UITableViewCell {
    //定义代理属性
    weak var delegate : TextAttristringDelegate?
    //模型赋值给控件
    var viewmodel : DZCDetalisViewModel?{
        
        didSet{
            //用户名
            usernamelabel.text=viewmodel?.weibomodel.user?.screen_name
            //显示文本
            textlabel.attributedText=viewmodel?.textattiment
            //vip头像
            vipimage.image=viewmodel?.vipimage
            //头像
           headimage.imageview(urlstring: viewmodel?.weibomodel.user?.profile_image_url ?? " ",
                                 iamge: UIImage.init(named:"avatar_default_big"), issuccess: true)
           //微博来源
            sourcelabel.text = viewmodel?.weibomodel.source?.regstring()
            //底部按钮
            repostsbtn.setTitle(viewmodel?.recount, for:.normal)

            commentsbtn.setTitle(viewmodel?.comcount, for: .normal)
            
            attitudesbtn.setTitle(viewmodel?.likecount, for: .normal)
           
           
            //视图模型复制
            imageview.viewmodelpic = viewmodel

           
            //vip等级标记
            vipicon.image=viewmodel?.vipicon
            
            repostlabel?.attributedText=viewmodel?.retweetedtext
            
        }
        
        
    }
    @IBOutlet weak var repostlabel: UILabel?
    @IBOutlet weak var vipicon: UIImageView!
    @IBOutlet weak var imageview: DZCWeiboPicView!
    @IBOutlet weak var repostsbtn: UIButton!
    @IBOutlet weak var vipimage: UIImageView!
    @IBOutlet weak var commentsbtn: UIButton!
   
    @IBOutlet weak var viewhight: NSLayoutConstraint!
    
    
    @IBOutlet weak var attitudesbtn: UIButton!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var headimage: UIImageView!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var sourcelabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.drawsAsynchronously = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

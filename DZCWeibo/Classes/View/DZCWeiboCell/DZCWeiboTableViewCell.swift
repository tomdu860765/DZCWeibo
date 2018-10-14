//
//  DZCWeiboTableViewCell.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/12.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCWeiboTableViewCell: UITableViewCell {
    
    
    //模型赋值给控件
    var viewmodel : DZCDetalisViewModel?{
        
        didSet{
            
            usernamelabel.text=viewmodel?.weibomodel.user?.screen_name
            
            textlabel.text=viewmodel?.weibomodel.text
            
            vipimage.image=viewmodel?.vipimage
            
            headimage?.imageview(urlstring: viewmodel?.weibomodel.user?.profile_image_url ?? " ",
                                 iamge: UIImage.init(named:"avatar_default_big"), issuccess: true)
            let str = viewmodel?.weibomodel.source
            
            sourcelabel.text? = (str?.stringcunt(strsource: str!, fromword: ">", endword: "<"))!
            
            repostsbtn.setTitle(viewmodel?.recount, for:.normal)
            

            commentsbtn.setTitle(viewmodel?.comcount, for: .normal)
            
            attitudesbtn.setTitle(viewmodel?.likecount, for: .normal)
           
            viewhight.constant=viewmodel?.picsize.height ?? 0
            
            imageview.picurl=viewmodel?.weibomodel.pic_urls
            
            vipicon.image=viewmodel?.vipicon
        }
        
        
    }
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
        
        
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

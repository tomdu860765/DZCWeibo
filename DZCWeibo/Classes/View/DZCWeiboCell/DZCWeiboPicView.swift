//
//  DZCWeiboPicView.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/14.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCWeiboPicView: UIView {
   
@IBOutlet weak var viewhight: NSLayoutConstraint!
    
    var viewmodelpic : DZCDetalisViewModel?{
        
        didSet{
            setpcihight()
            picurl = viewmodelpic?.imageurls
        }
    }
    private func setpcihight(){
    
        if viewmodelpic?.imageurls?.count == 1{
            let itemview = viewmodelpic?.picsize ?? CGSize()
            let subview = subviews.first
            subview?.frame=CGRect(x: 0, y: outtermargin,
                                  width: itemview.width,
                                  height: itemview.height)
            
        }
        
        else{
            let subview = subviews.first
            subview?.frame=CGRect(x: 0, y: outtermargin,
                                  width: itemviewwidth,
                                  height: itemviewwidth)
            
            
        }
        
        
      viewhight.constant=viewmodelpic?.picsize.height ?? 0
    
    }
    
    
    
  private  var picurl:[DZCPicModel]?{
        
        didSet{
            for subview in subviews {
                subview.isHidden=true
            }
            var index = 0
            
            for url in picurl ?? [] {
                let imagev = subviews[index] as! UIImageView
                if index==1 && picurl?.count==4{
                    index+=1
                }
                    
                imagev.imageview(urlstring: url.thumbnail_pic ?? " ", iamge: nil, issuccess: false)
                
                imagev.isHidden=false
                
                index+=1
                
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        setupview()
    }
    
}
//九宫格计算
extension DZCWeiboPicView{
    
    func setupview()  {
        //超出边界删除
        clipsToBounds=true
        let count = 3
        let itemrect = CGRect(x: 0, y: outtermargin, width: itemviewwidth , height: itemviewwidth )
        
        for i in 0..<count*count {
            let view = UIImageView()
            view.backgroundColor=UIColor.white
            //行
            let col = CGFloat(i/count)
            //列
            let row = CGFloat(i%count)
            
            let offsetX = row*(itemviewwidth+innermargin)
            
            let offsetY = col*(itemviewwidth+innermargin)
            
            view.frame=itemrect.offsetBy(dx: offsetX, dy: offsetY)
            
            addSubview(view)
            
        }
        
        
        
        
        
        
    }
    
    
    
    
}

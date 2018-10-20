//
//  DZCRefreshControl.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/20.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
private let maxheight : CGFloat = 150
enum viewstatus{
    case normal
    case pulling
    case stop
}


class DZCRefreshControl: UIControl {
    
    private weak var  scrollview : UIScrollView?
    
    private lazy var refreshview = DZCRefreashview.creatview()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setupuicontrol()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        
        guard let sv=newSuperview as? UIScrollView else {
            return
        }
        
       scrollview = sv
        
     scrollview?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
        
    }
    //监听kvo方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollview else{
            return
        }
        let height = abs( sv.contentOffset.y + sv.contentInset.top)
        if height<0 {
            return
        }
        
        self.frame = CGRect.init(x: 0, y: -height, width:UIScreen.main.bounds.width, height: height)
       
        if sv.isDragging {
        if height > maxheight && refreshview.status == .normal{
            
            
            refreshview.status = .pulling
           // print("开始刷新")
        }else if height<=maxheight && refreshview.status == .pulling{
            
            refreshview.status = .normal
           // print("继续拉就刷新")
        }else{
            if refreshview.status == .pulling{
                benginrefresh()
                sendActions(for: UIControl.Event.valueChanged)
            }

            }
        }
        
        
       
       // print(scrollview?.contentOffset as Any)
    }
    override func removeFromSuperview() {
        removeObserver(self, forKeyPath: "contentOffset")
        removeFromSuperview()
    }
    
   
    func benginrefresh()  {
        
        if  refreshview.status == .stop{
            return
        }
        
        guard let sv=scrollview else{
            
            return
        }
        refreshview.status = .stop
        var svinset = sv.contentInset
        svinset.top +=  maxheight
        sv.contentInset = svinset
        
        
    }
    
    
    func endrefresh() {
        guard let sv = scrollview else {
            return
        }
        
        refreshview.status = .normal
        
            var svinset = sv.contentInset
            svinset.top -=  maxheight
            sv.contentInset = svinset
        
      
        
    }
    
    
    
    
    

}
extension DZCRefreshControl{
    
    
    func  setupuicontrol()  {
        addSubview(refreshview)
        
        
        refreshview.translatesAutoresizingMaskIntoConstraints=false
        //添加约束
        addConstraint(NSLayoutConstraint.init(item: refreshview, attribute: .centerX,
                                              relatedBy: .equal, toItem: self,
                                              attribute: .centerX,
                                              multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: refreshview, attribute: .bottom,
                                              relatedBy: .equal, toItem: self,
                                              attribute: .bottom, multiplier: 1,
                                              constant: 0))
        addConstraint(NSLayoutConstraint.init(item: refreshview, attribute: .width,
                                              relatedBy: .equal, toItem: nil,
                                              attribute: .notAnAttribute, multiplier: 1,
                                              constant: refreshview.bounds.width))
        addConstraint(NSLayoutConstraint.init(item: refreshview, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1,
                                              constant: refreshview.bounds.height))
        
        
    }
    
    
}

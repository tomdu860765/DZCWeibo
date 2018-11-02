//
//  DZCWriteWeiboView.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/21.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import pop
class DZCWriteWeiboView: UIView {
    
    
    let btninfo = [["imagename":"compose_more_bigweibo","title":"文字","missionname":"textviewcontroller"],
                   ["imagename":"compose_photo_video_highlighted","title":"视频/照片","missionname":"photoviewcontroller"],
                   ["imagename":"compose_more_groupcard","title":"长微博","missionname":"longtextviewcontroller"],
                   ["imagename":"compose_publicbutton","title":"签到","missionname":"signinviewcontroller"],
                   ["imagename":"compose_more_transfer","title":"点评","missionname":"likeviewcontroller"],
                   ["imagename":"compose_new_group","title":"更多","missionname":"moresomething"],
                   ["imagename":"compose_friendcircle","title":"朋友圈","missionname":"friendsviewcontroller"],
                   ["imagename":"compose_toolbar_picture_highlighted","title":"微博相机","missionname":"careamviewcontroller"],
                   ["imagename":"compose_trendbutton_background_highlighted","title":"音乐","missionname":"musicviewcontroller"],
                   ["imagename":"compose_photo_photograph_highlighted","title":"拍摄","missionname":"screenviewcontroller"]
        
        
    ]
    
    private var completionblock :((String)->())?
    @IBOutlet weak var finishbtn: UIButton!
    //完成按钮坐标y约束
    @IBOutlet weak var finishbtnconstraint: NSLayoutConstraint!
    //取消按钮坐标x约束
    @IBOutlet weak var backbtncontraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnscroolview: UIScrollView!
    @IBOutlet weak var backbtn: UIButton!
    class func writeweibo()->DZCWriteWeiboView{
        let uib = UINib.init(nibName: "DZCWriteWeiboView", bundle: nil)
        let view = uib.instantiate(withOwner: nil, options: nil).last as! DZCWriteWeiboView
        view.frame = screenbounds
        view.creatbtnforsv()
        
        return view
        
    }
    @IBAction func getback(_ sender: UIButton) {
        
        
        dismissbtnanim()
        dismssv()
    }
    //返回第一屏幕按钮选择
    @IBAction func finishanback(_ sender: Any) {
        
        btnmoveshow()
        //返回原坐标
        btnscroolview.setContentOffset(CGPoint(x:0, y: 0), animated: false)
        
        backbtncontraint.constant = 0
        finishbtnconstraint.constant = 0
        finishbtn.isHidden = true
        UIView.animate(withDuration: 0.25) {
            
            self.layoutIfNeeded()
            
        }
        
    }
    
    
}
extension DZCWriteWeiboView{
    //FIX
    @objc private func loadviewcontroller(btn:DZCWriteWeiboBtn){
        clickbtn(dzcbtn: btn)
        
    }
    
    
    func show(finish:@escaping (String)->())  {
        completionblock = finish
        guard  let vc = UIApplication.shared.keyWindow?.rootViewController   else {
            return
        }
        vc.view.addSubview(self)
        showviewanim()
        
        btnmoveshow()
    }
    
    
    @objc private func moresomething(){
        btnmovesecond()
        btnscroolview.setContentOffset(CGPoint(x: screenbounds.width, y: 0), animated: false)
        let margin = screenbounds.width/6
        backbtncontraint.constant -= margin
        finishbtnconstraint.constant += margin
        finishbtn.isHidden = false
        UIView.animate(withDuration: 0.25) {
            
            self.layoutIfNeeded()
            
        }
        
    }
    
    
    private func creatbtnforsv(){
        
        //按钮大小
        let btnsize = CGSize(width: 80, height: 80)
        //创建另一个视图,并添加到滚动视图中
        let rect = btnscroolview.bounds
        let viewfirst = UIView(frame: rect)
        let viewsecond = UIView(frame: rect.offsetBy(dx: rect.width, dy: 0))
        btnscroolview.addSubview(viewfirst)
        btnscroolview.addSubview(viewsecond)
        for  (index,btndict) in btninfo.enumerated() {
            guard    let imagename = btndict["imagename"],
                let title = btndict["title"],
                let missionname = btndict["missionname"] else{
                    continue
            }
            let btn = DZCWriteWeiboBtn.creatbtn(imagename:imagename, title: title)
            
            
            //如果大于6在添加到另一个视图中
            if index>=6{
                
                
                btn.frame=btncontranst(index: index-6, btnsize: btnsize)
                
                viewsecond.addSubview(btn)
                
                
            }else{
                
                btn.frame = btncontranst(index: index, btnsize: btnsize)
                viewfirst.addSubview(btn)
                
            }
            if missionname == "moresomething"{
                btn.addTarget(self, action: Selector(missionname), for: .touchUpInside)}
            else{
                btn.classname = missionname
                btn.addTarget(self, action: #selector(loadviewcontroller), for: .touchUpInside)
            }
            
            
            btnscroolview.contentSize =  CGSize(width: screenbounds.width*2, height: 0)
            btnscroolview.bounces=false
            btnscroolview.showsVerticalScrollIndicator=false
            btnscroolview.showsHorizontalScrollIndicator=false
            btnscroolview.isScrollEnabled=false
            
            
        }
        
        
        
        
    }
    //计算九宫格布局
    private  func btncontranst(index:Int,btnsize:CGSize) -> CGRect {
        
        let btnmargin = (btnscroolview.bounds.width-3*btnsize.width)/4
        let y:CGFloat = (index>2) ? (btnscroolview.bounds.height-btnsize.height) : 0
        let col = index%3
        
        let x = CGFloat(col+1)*btnmargin+CGFloat(col)*btnsize.width
        
        return CGRect(x: x, y: y, width:btnsize.width , height:btnsize.height)
    }
    
    
}
//动画方法
private extension DZCWriteWeiboView{
    //视图出现
    private func showviewanim(){
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim?.fromValue=0
        anim?.toValue=1
        anim?.duration = 0.25
        
        pop_add(anim, forKey: nil)
    }
    //视图返回
    private func btnanimation(){
        let anim=POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        
        anim?.fromValue = Double.pi * 0.5
        anim?.toValue = 0
        anim?.duration = 0.25
        
        backbtn.pop_add(anim, forKey: nil)
    }
    //按钮跳动出现
    private func btnmoveshow(){
        let v = btnscroolview.subviews[0]
        
        
        for (i,btns) in v.subviews.enumerated() {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim?.fromValue = btns.center.y+400
            anim?.toValue = btns.center.y
            anim?.springBounciness = 6
            anim?.springSpeed = 12
            anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(i)*0.025
            anim?.removedOnCompletion = false
            
            btns.layer.pop_add(anim, forKey: nil)
            
        }
        
    }
    //第二界面的按钮跳动
    private func btnmovesecond(){
        let v = btnscroolview.subviews[1]
        
        for (i,btns) in v.subviews.enumerated() {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim?.fromValue = btns.center.y+400
            anim?.toValue = btns.center.y
            anim?.springBounciness = 6
            anim?.springSpeed = 12
            anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(i)*0.025
            anim?.removedOnCompletion = false
            btns.layer.pop_add(anim, forKey: nil)
        }
        
    }
    // 按钮消失动画
    private func dismissbtnanim(){
        let page = Int(btnscroolview.contentOffset.x/screenbounds.width)
        let view = btnscroolview.subviews[page]
        for (index,btns) in view.subviews.enumerated().reversed() {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim?.fromValue = btns.center.y
            anim?.toValue = btns.center.y + 400
            anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(view.subviews.count-index)*0.025
            btns.layer.pop_add(anim, forKey: nil)
            
            
        }
    }
    //撰写滚动视图消失动画
    
    private func dismssv(){
        
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim?.fromValue = 1
        anim?.toValue = 0
        anim?.duration = 0.25
        pop_add(anim, forKey: nil)
        anim?.completionBlock={(_,_)in
            
            self.removeFromSuperview()
        }
        
    }
    //点击按钮时动画
    private func clickbtn(dzcbtn:DZCWriteWeiboBtn){
        let page = Int(btnscroolview.contentOffset.x/screenbounds.width)
        let view = btnscroolview.subviews[page]
        for  (index, btn) in view.subviews.enumerated() {
            let anim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            let scale = (btn==dzcbtn) ? 2 : 0.2
            anim?.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            anim?.duration = 0.5
            btn.pop_add(anim, forKey: nil)
            let animaphfa = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            animaphfa?.toValue = 0.5
            animaphfa?.duration = 0.5
            pop_add(animaphfa, forKey: nil)
            if index == 0{
                animaphfa?.completionBlock={
                    (_,_)in
                    
                    guard let classname=dzcbtn.classname else{
                        return
                    }
                    self.completionblock?(classname)
                    self.removeFromSuperview()
                }
                
            }
            
        }
        
    }
    
    
}

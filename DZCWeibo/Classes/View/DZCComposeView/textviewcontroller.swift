//
//  textviewcontroller.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/31.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import SnapKit
class textviewcontroller: UIViewController {
    //添加导航左按钮
    lazy var leftbackbtn = UIBarButtonItem.init(title: "返回", style:.done ,
                                                target: self,action:#selector(getbackview) )
    
    //添加导航右按钮
    lazy var rightbtn :UIButton = {
        
        let btn =   UIButton()
        btn.setBackgroundImage(UIImage.init(named:"compose_guide_button_default" ), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "compose_guide_button_check"), for: .highlighted)
        btn.setBackgroundImage(UIImage.init(named:"compose_app_default" ), for: .disabled)
        btn.setTitle("发布", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.frame.size = CGSize(width: 45, height: 35)
        btn.addTarget(self, action: #selector(composeweibo), for: .touchUpInside)
        
        return btn
    }()
    
    
    let btnsbackground = [
        ["backimage":"compose_emoticonbutton_background","hightimage":"compose_emoticonbutton_background_highlighted"],
        [ "backimage":"compose_mentionbutton_background","hightimage":"compose_mentionbutton_background_highlighted"],
        ["backimage":"compose_toolbar_picture","hightimage":"compose_toolbar_picture_highlighted"],
        ["backimage":"compose_trendbutton_background","hightimage":"compose_trendbutton_background_highlighted"],
        ["backimage":"compose_toolbar_video","hightimage":"compose_toolbar_video_highlighted"]
    ]
    
    
    
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var placeholdlabel: UILabel!
    
    @IBOutlet weak var toolbarconstraint: NSLayoutConstraint!
    @IBOutlet weak var composetoolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let uib = UINib.init(nibName: "DZCtextview", bundle: nil)
        guard let composeview = uib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.addSubview(composeview)
        navigationItem.leftBarButtonItem = leftbackbtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightbtn)
        navigationItem.rightBarButtonItem?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(kbframechange),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(beginedit),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: nil)
        
        toolbarbtnsetup()
        
    }
    //键盘跳出方法
    @objc func kbframechange(n:Notification){
        guard let rect = (n.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue
            else {
                return
        }
        let offset =  view.bounds.height - rect.origin.y
        toolbarconstraint.constant = -offset
        
        
    }
    
    //返回微博视图
    @objc func getbackview(){
        
        dismiss(animated: true) {
            
            
        }
        
    }
    //微博发布方法,微博官方已屏蔽第三方写入端口
    @objc func composeweibo(){
        
        guard let text=textview.text else {
            return
        }
        let image = UIImage.init(named: "compose_camerabutton_background_highlighted")
        
        DZCNetWorkManager.DefaultNetWork.postweibonetwork(text: text, image: image) { (json, issuccess) in
            
            if issuccess==true{
                print(json as Any)
                print("发布成功请刷新")
            }else{
                
                print("发布不成功")
            }
            
            
        }
        
        
        print("发布微博")
    }
    //文本开始输入的时候
    @objc func beginedit(){
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        textview.text = ""
        
    }
    
    deinit{
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    
    
}

private extension textviewcontroller{
    
    //设置toolbar
    func toolbarbtnsetup()  {
        
        
        var barbtns = Array<AnyObject>()
        
        for image in btnsbackground {
            guard let imagenorml=image["backimage"],
                let hlimage = image["hightimage"]else{
                    continue
            }
            let btn = UIButton()
            btn.setImage(UIImage.init(named:imagenorml), for: .normal)
            btn.setImage(UIImage.init(named:hlimage), for: .highlighted)
            btn.sizeToFit()
            
            let toolbarbtn = UIBarButtonItem.init(customView: btn)
            
            
            barbtns.append(toolbarbtn)
            
            barbtns.append(UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil))
            
        }
        barbtns.removeLast()
        
        composetoolbar.items = barbtns as? [UIBarButtonItem]
        
    }
    
    
    
}


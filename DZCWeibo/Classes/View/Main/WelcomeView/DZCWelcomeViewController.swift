//
//  DZCWelcomeViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/11.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCWelcomeViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var welcomelabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setheadimage()
    }
    
    override func viewWillLayoutSubviews() {
        
        self.moveimage()
        
        self.movelabel()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.showlabel()
        }
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5) {
            
            UIApplication.shared.keyWindow?.rootViewController=DZCMainViewController()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
extension DZCWelcomeViewController{
    
    private   func setheadimage()  {
        guard     let modelstr = DZCNetWorkManager.DefaultNetWork.account.avatar_large,
            let urlpic = URL(string: modelstr ) else{
                
                return
        }
        imageview.contentMode = .scaleAspectFit
        
        imageview.setImageWith(urlpic, placeholderImage: UIImage.init(named: "avatar_default_big"))
    
        imageview.layer.cornerRadius = imageview.bounds.size.width / 2
        
       
        imageview.layer.masksToBounds = true;
        
    }
    private    func moveimage()  {
        let  anim = CABasicAnimation.init(keyPath: "position.y")
        anim.fromValue=imageview.frame.origin.y
        anim.toValue=imageview.frame.origin.y-100
        anim.duration=3
        anim.isRemovedOnCompletion=false
        anim.fillMode = CAMediaTimingFillMode.forwards
        imageview.layer.add(anim, forKey: "goup")
        
    }
    private func movelabel(){
        let labelanim = CABasicAnimation.init(keyPath: "position.y")
        labelanim.fromValue=welcomelabel.frame.origin.y
        labelanim.toValue=welcomelabel.frame.origin.y-100
        labelanim.duration=3
        labelanim.isRemovedOnCompletion=false
        labelanim.fillMode = CAMediaTimingFillMode.forwards
        welcomelabel.layer.add(labelanim, forKey: nil)
    }
    private func showlabel(){
        let  showanim = CABasicAnimation.init(keyPath: "opacity")
        showanim.fromValue=welcomelabel.alpha
        showanim.toValue=welcomelabel.alpha+1
        showanim.duration=2
        showanim.isRemovedOnCompletion=false
        showanim.fillMode = CAMediaTimingFillMode.forwards
        welcomelabel.layer.add(showanim, forKey: "showlabel")
    }
    
}

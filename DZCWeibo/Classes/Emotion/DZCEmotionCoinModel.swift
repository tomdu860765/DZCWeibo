//
//  DZCEmotionCoinModel.swift
//  DZCRegularExpression
//
//  Created by tomdu on 2018/10/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
@objcMembers
class DZCEmotionCoinModel: NSObject {
    //延迟加载空数组
    lazy var emotionCoin = [DZCEmotionModel]()
    //文件夹属性
    var id : String? {
        
        didSet{
            guard let id = id ,
                let bundel = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
                let pathbundel  = Bundle.init(path: bundel),
                let infopath =  pathbundel.path(forResource:"info.plist" , ofType: nil, inDirectory: id),
                let dict = NSDictionary.init(contentsOfFile: infopath),
                let array = dict.value(forKey: "emoticons") as? [[String:String]],
                let arraymodel = NSArray.yy_modelArray(with: DZCEmotionModel.self, json: array as AnyObject) as? [DZCEmotionModel]
                else {
                    return
            }
         
            for m in arraymodel {
               m.id = id
               
            }
           emotionCoin += arraymodel
      
            
        }
        
    }
    
    var version:String?
    
    
    
    
}

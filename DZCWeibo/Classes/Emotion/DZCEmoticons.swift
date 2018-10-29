//
//  DZCEmoticons.swift
//  DZCRegularExpression
//
//  Created by tomdu on 2018/10/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
import YYModel
class DZCEmoticons {
    
    
    static let DefualtManger = DZCEmoticons()
    //设立空模型数组
    lazy var Emotionarray = [DZCEmotionCoinModel]()
    
    private init(){
        
        emotionarray()
        
    }
}



extension DZCEmoticons{
    //字典转模型方法
    func emotionarray()  {
        guard    let emobundle = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
            let plistbudle = Bundle.init(path: emobundle),
            let  plistpath = plistbudle.path(forResource: "emoticons.plist", ofType: nil),
            let plistdict = NSDictionary(contentsOfFile: plistpath),
            let plistarray = plistdict.value(forKey: "packages") as? [[String:AnyObject]],
            let models =  NSArray.yy_modelArray(with:DZCEmotionCoinModel.self , json: plistarray as [[String:AnyObject]]) as? [DZCEmotionCoinModel]
            else{
                
                return
        }
        
        Emotionarray += models
        
        
        
    }
    //寻找模型中表情字符串返回方法
    func foundEmotion(str:String) -> DZCEmotionModel  {
        
        for models in Emotionarray {
            
           
      let result = models.emotionCoin.filter { (DZCEmotionModel) -> Bool in
                
             return  DZCEmotionModel.chs == str
        
            }
            
            if result.count == 1{
                
                return result.first ?? DZCEmotionModel()
            }
            
            
        }
        return DZCEmotionModel()
    }
    //处理文本中表情方法
    func emtionString(string:String,font:UIFont) -> NSAttributedString {
        let attristring = NSMutableAttributedString.init(string: string)
        
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression.init(pattern: pattern, options: []) else {
            return attristring
        }
        
        let matches = regx.matches(in: string, options: [], range: NSRange.init(location: 0, length: attristring.length))
        
        for mtext in matches.reversed() {
            let range = mtext.range(at: 0)
            
            let substring = (attristring.string as NSString).substring(with: range)
            let em = DZCEmoticons.DefualtManger.foundEmotion(str: substring)
            
            attristring.replaceCharacters(in: range, with: em.imagetext(font: font))
            
            
        }
      attristring.addAttributes([NSAttributedString.Key.font : font ] , range: NSRange.init(location: 0, length: attristring.length))
        return attristring
    }
    
    
}

//
//  DZCLabel.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/29.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit

class DZCLabel: UILabel {
     //文本存储
    lazy var labelstorage = NSTextStorage()
    //文本布局
    lazy var labellayout = NSLayoutManager()
    //文本绘制范围
    lazy var labelcontainer = NSTextContainer()
    
    override var text: String?{
        
        didSet{
            
            readyFortextlabel()
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        readyFortextlabel()
    }
    //xib绘制label
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        readyFortextlabel()
    }
    //重写触摸方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  let labeltouchues = touches.first?.location(in: self) else{
            return
        }
        //获取索引
        let index = labellayout.glyphIndex(for: labeltouchues, in: labelcontainer)
        //作网页跳转
        for urlstrrange in urlrang ?? [] {
            if NSLocationInRange(index, urlstrrange){
                
                print("网页跳转")
            }
            
            
        }
        setNeedsDisplay()
        
        
    }
    
    //重写绘制方法
    override func drawText(in rect: CGRect) {
        let rang = NSRange.init(location: 0, length: labelstorage.length)
        
        
        labellayout.drawGlyphs(forGlyphRange: rang, at: CGPoint())
        
    }
    
    override func layoutSubviews() {
        
        labelcontainer.size = bounds.size
        
        
    }
    
   
}
private extension DZCLabel{
    //准备label图文表示
    func readyFortextlabel()  {
        labelStroage()
        
        labelstorage.addLayoutManager(labellayout)
        
        labellayout.addTextContainer(labelcontainer)
        
    }
    //对于label字符的显示排版
    func labelStroage()  {
        
        if let attributedText = attributedText {
            labelstorage.setAttributedString(attributedText)
        }else if let labeltext = text {
            labelstorage.setAttributedString(NSAttributedString.init(string: labeltext))
            
        }else{
            labelstorage.setAttributedString(NSAttributedString.init(string: ""))
        }
        
        for r in urlrang ?? [] {
           labelstorage.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: r)
        }
        
        
    }
 
    
}
//labell扩展http正则表达式属性
private extension DZCLabel{
    var  urlrang :[NSRange]?  {
        
         let pattern = "[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?"
        guard let regx = try? NSRegularExpression.init(pattern: pattern, options: []) else{
            
            return []
        }
        let matches = regx.matches(in: labelstorage.string, options: [], range: NSRange.init(location: 0, length: labelstorage.length))
        
        var rang = [NSRange]()
        
        for m in matches {
            rang.append(m.range(at: 0))
        }
        
       return rang
    }
    
    
    
}

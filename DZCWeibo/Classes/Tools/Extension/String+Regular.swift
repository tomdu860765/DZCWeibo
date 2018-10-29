//
//  String+Regular.swift
//  DZCRegularExpression
//
//  Created by tomdu on 2018/10/26.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation


extension String{
    
    
    func regstring()->(String){
        let string = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        guard let reg = try? NSRegularExpression(pattern: string, options: []),
            let resurl = reg.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) else{
                return " "
        }
        
        // let link = (self as NSString).substring(with: resurl.range(at: 1))
        let  devicestr = (self as NSString).substring(with: resurl.range(at: 2))
        return "来自 " + devicestr
    }
    
    
    
}

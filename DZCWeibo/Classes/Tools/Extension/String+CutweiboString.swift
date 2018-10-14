//
//  String+CutweiboString.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/13.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
///针对微博返回字段的截取方法,其他程序可能不适用

extension String{
    
    func stringcunt(strsource:String,fromword:String,endword:String,addfirstword:String="来自")->String  {
        //获取字符串位置
        if strsource==""{
          return ""
        }
        let firststrindex = strsource.firstIndex(of: Character.init(fromword))
       
        
        let firststr = strsource[firststrindex!..<strsource.lastIndex(of: Character.init(endword))!]
       
        
        return addfirstword+String(firststr.dropFirst(1))
    }
    

    
}

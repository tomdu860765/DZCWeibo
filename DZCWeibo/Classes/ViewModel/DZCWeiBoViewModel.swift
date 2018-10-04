//
//  DZCWeiBoModel+Modeldata.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation

class WeiBoListArrayModel {
    //定义数组模型懒加载
lazy var  listarray=[DZCWeiboModel]()
    func loadarray(completion: @escaping (Bool)->()){
        DZCNetWorkManager.DefaultNetWork.WeiBoRequest { (jsonarray, issuccess) in
           
          guard  let array = NSArray.yy_modelArray(with: DZCWeiboModel.self, json: jsonarray ?? []) as? [DZCWeiboModel]
            else{
                completion(false)
                return}
           completion(true)
            self.listarray+=array
            
            
        }
        
    }






}

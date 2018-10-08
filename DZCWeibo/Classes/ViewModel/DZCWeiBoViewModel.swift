//
//  DZCWeiBoModel+Modeldata.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation

private let Max_count=3

class WeiBoListArrayModel {
    //定义数组模型懒加载
    lazy var  listarray=[DZCWeiboModel]()
    //限制刷新次数
    private  var refrashcount = 0
    
    
    func loadarray(ispull:Bool,completion: @escaping (Bool,_ Morerefash:Bool)->()){
        
        if ispull && refrashcount > Max_count{
            completion(true,false)
            return
        }
        
        let since_id = ispull==true ? 0 : (listarray.first?.id ?? 0)
        let  max_id = ispull==false ? 0 : (listarray.last?.id ?? 0)
        DZCNetWorkManager.DefaultNetWork.WeiBoRequest(since_id: since_id, max_id: max_id) { (jsonarray, issuccess) in
            
            guard  let array = NSArray.yy_modelArray(with: DZCWeiboModel.self, json: jsonarray ?? []) as? [DZCWeiboModel]
                else{
                    completion(false,false)
                    return}
            print("刷新了\(array.count)条")
            
            if ispull{
                self.listarray+=array
                self.refrashcount+=1
            }else
            {
                self.listarray=array+self.listarray
                self.refrashcount+=1
                
            }
            if ispull && array.count==0{
                
                self.refrashcount+=1
                
            }
            
            completion(true,true)
            
        }
        
    }
    
    
    
    
    
    
}

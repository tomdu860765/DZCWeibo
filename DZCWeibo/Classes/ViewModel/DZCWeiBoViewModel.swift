//
//  DZCWeiBoModel+Modeldata.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
//最高微博刷新次数
private let Max_count=5

class WeiBoListArrayModel {
    //定义数组模型懒加载
    lazy var  listarray=[DZCDetalisViewModel]()
    //限制刷新次数
    private  var refrashcount = 0
    
    
    func loadarray(ispull:Bool,completion: @escaping (Bool,_ Morerefash:Bool)->()){
        
        if ispull && refrashcount > Max_count{
            completion(true,false)
            return
        }
        
        let since_id = ispull==true ? 0 : (listarray.first?.weibomodel.id ?? 0)
        let  max_id = ispull==false ? 0 : (listarray.last?.weibomodel.id ?? 0)
        DZCNetWorkManager.DefaultNetWork.WeiBoRequest(since_id: since_id, max_id: max_id) { (jsonarray, issuccess) in
            
            if  issuccess == false{
                completion(false,false)
                return
            }
            var viewmodelarray = [DZCDetalisViewModel]()
            
            for dict in jsonarray ?? []{
                
                guard let modelview = DZCWeiboModel.yy_model(with: dict) else{
                    continue
                }
                
                viewmodelarray.append(DZCDetalisViewModel.init(model: modelview))
                
            }
           
            if ispull{
                self.listarray+=viewmodelarray
                self.refrashcount+=1
            }else
            {
                self.listarray=viewmodelarray+self.listarray
                self.refrashcount+=1
                
            }
            if ispull && viewmodelarray.count==0{
                
                self.refrashcount+=1
                
            }
            
            completion(true,true)
            
        }
        
    }
    
    
    
    
    
    
}

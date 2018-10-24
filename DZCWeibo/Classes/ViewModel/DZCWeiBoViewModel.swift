//
//  DZCWeiBoModel+Modeldata.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/4.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
import SDWebImage
//最高微博刷新次数
private let Max_count=3

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
                print("下啦刷新不成功")
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
                print("执行刷新")
                self.listarray=viewmodelarray+self.listarray
                
                self.refrashcount+=1
            }else
            {
                self.listarray+=viewmodelarray
                self.refrashcount+=1
                
            }
            if ispull && viewmodelarray.count==0{
                
                self.refrashcount+=1
                
            }
            
           self.cachesignpic(modelpics: viewmodelarray, didfinish: completion)
        }
        
     
        
        
    }
    
    private func cachesignpic(modelpics:[DZCDetalisViewModel],didfinish:@escaping ((Bool,_ Morerefash:Bool)->())){
        let group = DispatchGroup()
        
        
        for picsmodel in modelpics {
            if  picsmodel.imageurls?.count != 1{
                continue
            }
            guard  let firstpicurl = picsmodel.imageurls?.first?.thumbnail_pic,
                   let picurl = URL.init(string: firstpicurl)else{
                    continue
            }
            group.enter()
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: picurl, options: [], progress: nil, completed: { (image, _, _, _) in
                guard let image = image else{
                    
                    return
                }
                picsmodel.updatapic(pic: image )
               
                group.leave()
            })
            group.notify(queue: DispatchQueue.main) {
                didfinish(true,true)
                
            }
            
        }
      
        
        
        
    }
    
    
    
    
    
}

//
//  DZCCollectionViewController.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/9.
//  Copyright © 2018 tomdu. All rights reserved.
//

import UIKit
import SnapKit
private let reuseIdentifier = "Cell"

class DZCCollectionViewController: UICollectionViewController {
    
    
  private  let array = ["new_feature_1","new_feature_2","new_feature_3","new_feature_4"]
    
    private lazy var btn:UIButton={
        let newFeaturebtn=UIButton.init(NormalBackgroundImage:"new_feature_finish_button",
                                        Image: " ",
                                        SelectedBackgroundImage: "new_feature_finish_button_highlighted",
                                        SelectedImage: " ")
        newFeaturebtn.setTitle("点击进入", for: .normal)
        newFeaturebtn.setTitleColor(UIColor.white, for: .normal)
        newFeaturebtn.alpha=0
        
        return newFeaturebtn
    }()
    
    private lazy var pagecontrol:UIPageControl={
        let page=UIPageControl()
        page.numberOfPages=array.count
        page.pageIndicatorTintColor=UIColor.black
        page.currentPageIndicatorTintColor=UIColor.orange
        
        page.sizeToFit()
      
        return page
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vcflowlayout()
      
        
        self.view.addSubview(pagecontrol)
        
        pagecontrol.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.bottom.equalToSuperview().offset(-50)
        })
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x/screenbounds.size.width+0.5
        pagecontrol.currentPage = Int(page)
        if pagecontrol.currentPage == 3 {
            self.view.addSubview(btn)
           
            btn.addTarget(self, action: #selector(showmainvc), for: .touchDown)
            btn.snp.makeConstraints { (ConstraintMaker) in
                ConstraintMaker.centerX.equalToSuperview()
                ConstraintMaker.centerY.equalToSuperview().offset(150)
            }
            UIView.animate(withDuration:0.25) {
                self.btn.alpha=1
            }

        }else{
            UIView.animate(withDuration:0.05) {
                self.btn.alpha=0
            }
            
        }
  
    }
    @objc private func showmainvc(){
        
        UIApplication.shared.keyWindow?.rootViewController=DZCMainViewController()
        
       
       self.dismiss(animated: true, completion: nil)
    }
        
    

    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imagename = array[indexPath.row]
        let imageview = UIImageView.init(image: UIImage.init(named: imagename))
        imageview.frame = screenbounds
        cell.contentView.addSubview(imageview)
       

       
        return cell
    }
    
    
}
extension DZCCollectionViewController{
    private func vcflowlayout(){
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize=screenbounds.size
        flowlayout.minimumInteritemSpacing=0
        flowlayout.minimumLineSpacing=0
        flowlayout.scrollDirection = .horizontal
        collectionView.bounces=false
        collectionView.showsHorizontalScrollIndicator=false
        collectionView.isPagingEnabled=true
        
        self.collectionView.collectionViewLayout=flowlayout
        
        
    }
    
    
}

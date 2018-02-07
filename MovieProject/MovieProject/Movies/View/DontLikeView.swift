//
//  DontLikeView.swift
//  MovieProject
//
//  Created by Bert on 16/8/26.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

class DontLikeView: UIView {
    
    
    let bgImageView = UIView()
    let titleLab = UILabel()
    var dontLikeBtn = UIButton()
    
   override init(frame: CGRect) {
        super.init(frame: frame)

    self.addSubview(bgImageView)
    
    
    titleLab.text = "不喜欢此类内容请点击"
    titleLab.textColor = UIColor.red
    titleLab.font = UIFont.systemFont(ofSize: 14)
    self.addSubview(titleLab)
    titleLab.backgroundColor = UIColor.white
    titleLab.layer.cornerRadius = 5
    titleLab.layer.masksToBounds = true
    dontLikeBtn = UIButton.init(type: UIButtonType.custom)
    dontLikeBtn.backgroundColor = UIColor.red
    dontLikeBtn.setTitle("不感兴趣", for:  UIControlState())
    dontLikeBtn.layer.cornerRadius = 10
    self.addSubview(dontLikeBtn)
    

    bgImageView.backgroundColor = UIColor.white
    bgImageView.layer.cornerRadius = 5
    bgImageView.layer.masksToBounds = true
    bgImageView.snp.updateConstraints { (make) in
//        make.right.equalTo(0)
        make.top.equalTo(0)
        make.size.equalTo(CGSize(width: 300, height: 46))
        make.right.equalTo(10)
        
    }

   
    dontLikeBtn.snp.makeConstraints { (make) in
        make.right.equalTo(-10)
        make.top.equalTo(2)
        make.size.equalTo(CGSize(width: 90, height: 42))
    }
    
    titleLab.snp.makeConstraints { (make) in
        make.right.equalTo(dontLikeBtn.snp.left).offset(-10)
        make.top.equalTo(2)
        make.size.equalTo(CGSize(width: 150, height: 42))
    }
     
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

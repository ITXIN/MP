//
//  MPAlertView.swift
//  MovieProject
//
//  Created by Bert on 16/9/27.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
import SnapKit



class MPAlertView: UIView {
    var alertView = UIView()
    var titleLab = UILabel()
    
    var contentLab = UILabel()
    var cancelBtn = UIButton()
    var yesBtn = UIButton()
    var lineHView = UIView()
    var lineVView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        self.addSubview(alertView)
        alertView.backgroundColor = UIColor.white;
        alertView.layer.cornerRadius = 5;
        alertView.layer.masksToBounds = true;
        
        
        alertView.addSubview(titleLab);
        titleLab.text = "title"
        
        titleLab.textAlignment = NSTextAlignment.center;
        titleLab.font = UIFont.systemFont(ofSize: 15)
        
        
        alertView.addSubview(contentLab)
        self.contentLab.textColor = RGBA(236, G: 0, B: 61,A: 1);
        
        
        self.contentLab.font = UIFont.systemFont(ofSize: 13);
        self.contentLab.textAlignment = NSTextAlignment.center;
        
        
        
        alertView.addSubview(lineHView)
        lineHView.backgroundColor = RGBA(244, G: 244, B: 244,A: 1);
        
        alertView.addSubview(lineVView)
        lineVView.backgroundColor = RGBA(244, G: 244, B: 244,A: 1);
        
        
        
        alertView.addSubview(cancelBtn)
        cancelBtn.setTitleColor(RGBA(146, G: 146, B: 146,A: 1), for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        cancelBtn.setTitle("Cancel", for: UIControlState.normal)
        cancelBtn.addTarget(self, action:#selector(self.cancelBtnClick(_:)), for: UIControlEvents.touchUpInside)
        
        cancelBtn.tag = 100;
        
        
        
        alertView.addSubview(yesBtn)
        yesBtn.setTitleColor(RGBA(146, G: 146, B: 146,A: 1), for: UIControlState.normal)
        yesBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        yesBtn.setTitle("Yes", for: UIControlState.normal)
        yesBtn.addTarget(self, action:#selector(self.cancelBtnClick(_:)), for: UIControlEvents.touchUpInside)
        
        yesBtn.tag = 101;
        
        
        self.setupConstarins()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstarins()
    {
        self.alertView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 28, height: 162));
            make.center.equalTo(self);
        }
        
        self.titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(35);
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 28, height: 17));
            make.centerX.equalTo(alertView);
        }
        
        
        self.contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(25);
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 28, height: 15));
            make.centerX.equalTo(alertView);
        }
        
        
        self.lineHView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentLab.snp.bottom).offset(26);
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 28, height: 1));
            make.centerX.equalTo(alertView);
        }
        
        
        self.cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineHView.snp.bottom).offset(1)
            
            make.left.equalTo(2);
            make.size.equalTo(CGSize(width: (SCREEN_WIDTH - 28)/2-4, height: 40));
        }
        
        
        self.yesBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineHView.snp.bottom).offset(1)
            make.right.equalTo(-2);
            make.size.equalTo(CGSize(width: (SCREEN_WIDTH - 28)/2-4, height: 40));
        }
        
        
        self.lineVView.snp.makeConstraints { (make) in
            make.top.equalTo(lineHView.snp.bottom).offset(0);
            make.size.equalTo(CGSize(width: 1, height: 45));
            make.centerX.equalTo(alertView);
        }
        
        
    }
    
    
    func cancelBtnClick(_ sender:UIButton) {
        
        
    }
    
    
    //    - (void)yesBtnClick:(UIButton *)sender
    //    {
    //    if (self.conflrmDelegate && [self.conflrmDelegate respondsToSelector:@selector(conflrmBtnClick:)])
    //    {
    //    [self.conflrmDelegate conflrmBtnClick:sender];
    //    }
    //    }
    
}

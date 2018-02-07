//
//  NavigationCustomView.swift
//  MovieProject
//
//  Created by Bert on 16/8/30.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

/**
 *  详情
 */
protocol NavigationCustomViewDelegate:NSObjectProtocol {
    func btnAction(_ sender:UIButton)

}


class NavigationCustomView: UIView {
    var navigationDelegate:NavigationCustomViewDelegate!//代理
    let leftBtn = UIButton.init(type: UIButtonType.custom)
    let rightBtn = UIButton.init(type: UIButtonType.custom)
    var blurView:UIVisualEffectView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        //接着创建一个承载模糊效果的视图
        blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView!.frame.size = CGSize(width: frame.width, height: frame.height)
        
        //创建并添加vibrancy视图
        let vibrancyView = UIVisualEffectView(effect:
            UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.frame.size = CGSize(width:frame.width, height: frame.height)
        blurView!.contentView.addSubview(vibrancyView)
        blurView?.alpha = 0.5
        self.addSubview(blurView!)
//        self.backgroundColor = UIColor.clearColor()
        
        
//        leftBtn.backgroundColor = UIColor.yellowColor()
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.setImage(UIImage.init(named: "leftBack"), for: UIControlState())
        leftBtn.tag = 1000
        self.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        leftBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)

       
        rightBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightBtn.setImage(UIImage.init(named: "share"), for: UIControlState())
        rightBtn.tag = 1001
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        rightBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        
    }
    func btnClick(_ sender:UIButton)  {
        
        if (navigationDelegate != nil)
        {
            navigationDelegate.btnAction(sender)
        }
        
        print("--------letfBtnClick ")

        
    }
    
    func hiddenNavigationViewWithAnimation()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: SCREEN_WIDTH, height: self.frame.height)
        }) 
    }
    func showNavigationViewWithAnimation()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.frame.height)
        }) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
